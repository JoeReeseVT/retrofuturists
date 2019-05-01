/*
 *	Module to generate a variable-frequency clock based on the player's velocity.
 *	First converts the signed velocity to unsigned speed. Each speed corresponds
 *	to a reference value used to determine when the output inverts. Higher speed
 *  means lower reference value, which means shorter clock period, which means
 *	more frequent position updating, which means more frequent position updating.
 *
 *  The exception is zero velocity, which will never invert the output.
 * 
 *	Uses the iCE40UP5K's 10kHz low-speed oscillator to reduce the number of bits
 *	needed for the counter.
 *
 *	Inputs:
 *		clk_10k  - 10 kHz input clock.
 *		velocity - Player's 4-bit signed velocity (along one axis).
 *
 *	Outputs:
 *		clk_o - Output clock, frequency dependent on magnitude of velocity.
 *
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pos_clk is
	port(
		clk_10k  : in  std_logic;
		velocity : in  signed(3 downto 0);
		
		clk_o 	 : out std_logic
  );
end pos_clk;

architecture synth of pos_clk is

signal ref   : unsigned(8 downto 0);
signal count : unsigned(8 downto 0);

signal spd : unsigned(2 downto 0); -- Holds the magnitude of velocity.
signal tmp : unsigned(3 downto 0); -- Used in speed calculation.

begin
	tmp <= unsigned(abs(velocity));
	spd <= tmp(2 downto 0);

  /* 
	 *  The reference values were calculated based on a max desired player
	 *  velocity of ~= 120 pixels per second. 
	 *		ref = (1/2)(10 kHz / (120 Hz * velocity / 7)
	 *
	 */
  ref <= 9d"0"   when spd = 3d"0" 
	  else 9d"292" when spd = 3d"1" 
		else 9d"146" when spd = 3d"2" 
		else 9d"97"  when spd = 3d"3" 
		else 9d"73"  when spd = 3d"4" 
		else 9d"58"  when spd = 3d"5" 
		else 9d"49"  when spd = 3d"6" 
		else 9d"42"  when spd = 3d"7";

	process(clk_10k) begin
		if rising_edge(clk_10k) then
		
		  if ref > 10d"0" then
				if count < ref then
					count <= count + 9d"1";
				else
					clk_o <= not clk_o;
					count <= 9d"0";
				end if;
		  else
			  clk_o <= clk_o;
				count <= count;
			end if;
			
	  end if;
	end process;
end;