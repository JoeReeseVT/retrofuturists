/*  
 *  Module to process and modify the player's position. Includes logic to wrap around 
 *  the screen if we go out of the visible range.
 *
 *	Works by incrementing or decrementing the player's row/col when the corresponding 
 *  x/y update signal is received. Position is only ever modified by 1 or -1, but the 
 *  rate at	which they update is controlled by the frequencies of clk_x and clk_y.
 *
 *  To determine whether to incrememnt or decrement, the most significant bit of the
 *	signed velocity value is taken. (Takes advantage of two's complement.)
 *
 *  Nobody knows why the if/elsif structure works to latch the row/col initialization.
 *
 *	Inputs:
 *		reset   - Active LOW signal used to initialize the player's position.
 *		player  - 0 correspons to first player, 1 to second player. Used to set each
 *						  Player at different initial coordinates. 
 *		clk_x/y - Variable-frequency clock signal to adjust the rate at which position
 *							Updates in each axis. Gives the impression of different velocities.
 *							The frequnecy is calculated by the pos_clk module.
 *
 *	Outputs:
 *		neg_x/y - Most significant bit of the player's signed two's complement velocity.
 *							Flag indicates wether the velocity along each axis is negative.
 *		row/col - Player's current position on the screen. (479,639) is bottom-right.
 *
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity position is
  port(
	  reset    : in  std_logic;
		player   : in  std_logic;
		
    clk_x    : in  std_logic; -- variable freq
		clk_y    : in  std_logic; -- variable freq
		
		neg_x    : in  std_logic; 
		neg_y    : in  std_logic;
		
    row      : out unsigned(9 downto 0);
    col      : out unsigned(9 downto 0)
  );
end position;

architecture synth of position is

begin        
  process (clk_x, reset) begin
		
		if not reset then
			if player then
				col <= 10d"70";
			else
				col <= 10d"30";
			end if;
				
    elsif rising_edge(clk_x) then 
			if col > 10d"831" then -- If we went off the left edge
				col <= 10d"639";
			elsif col > 10d"639" and col < 10d"832" then -- If we went off the right edge
				col <= 10d"0";
			else 
				if neg_x then
					col <= col - 10d"1";
				else
					col <= col + 10d"1";
				end if;
			end if;
			
		end if;
	end process;

	process (clk_y, reset) begin
		
		if not reset then
  		row <= 10d"310"; 

		elsif rising_edge(clk_y) then 
			if row > 10d"751" then -- If we went off the top edge
				row <= 10d"479";
			elsif row > 10d"479" and row < 10d"752" then -- If we went off the bottom edge
				row <= 10d"0";
			else 
				if neg_y then
					row <= row - 10d"1";
				else
					row <= row + 10d"1";
				end if;
			end if;	
			
    end if;
  end process;
end;