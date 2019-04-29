library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pos_clk is
	port(
		clk10k  : in std_logic;
		velocity : in signed(3 downto 0);
		clk_o : out std_logic
  );
end pos_clk;

architecture synth of pos_clk is

signal ref : unsigned(8 downto 0);
signal count : unsigned(8 downto 0);

signal spd : unsigned(2 downto 0); -- Holds the "absolute value" of the signed velocity
signal tmp : unsigned(3 downto 0); -- Used in the conversion from signed to unsigned

begin
	tmp <= unsigned(abs(velocity));
	spd <= tmp(2 downto 0);

  ref <= 9d"0"   when spd = 3d"0" else
				 9d"292" when spd = 3d"1" else
	       9d"146" when spd = 3d"2" else
				 9d"97"  when spd = 3d"3" else
				 9d"73"  when spd = 3d"4" else
				 9d"58"  when spd = 3d"5" else
				 9d"49"  when spd = 3d"6" else
				 9d"42"  when spd = 3d"7";
/*				 
				 9d"390" when spd = 3d"1" else
	       9d"194" when spd = 3d"2" else
				 9d"129" when spd = 3d"3" else
				 9d"97"  when spd = 3d"4" else
				 9d"78"  when spd = 3d"5" else
				 9d"65"  when spd = 3d"6" else
				 9d"55"  when spd = 3d"7";
*/

	process(clk10k) begin
		if rising_edge(clk10k) then
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