/*  
 *  Module to output 6-digit RGB signal corresponding to a car sprite.
 *  Constraints generated by bmp_to_vhd.
 *  
 *  Author(s):
 *    Joe
 *   
 *  Version: 0.1.0
 *  Updated: 26 Apr 2019 by Joe
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sprite_rgb is
  port(
    vga_row, vga_col, pos_row, pos_col : in unsigned(9 downto 0);
    direction : in unsigned(2 downto 0);
    sprite_on : out std_logic;
    rgb_o : out std_logic_vector(5 downto 0)
  );
end sprite_rgb;

architecture synth of sprite_rgb is

signal color : std_logic_vector(5 downto 0);

begin
  sprite_on <= '0' when rgb_o = "000000" else '1';
								 
	color <= "000011" when direction = 3d"0" else
		  		 "001111" when direction = 3d"1" else
					 "001100" when direction = 3d"2" else
					 "111100" when direction = 3d"3" else
					 "110000" when direction = 3d"4" else
					 "110011" when direction = 3d"5" else
					 "101010" when direction = 3d"6" else
					 "111111" when direction = 3d"7" else
					 "000000";
						 	 
	rgb_o <= color when vga_col > pos_col - 10d"20" and vga_col < pos_col + 10d"20" and vga_row > pos_row - 10d"20" and vga_row < pos_row + 10d"20"
								 else "000000";

end;