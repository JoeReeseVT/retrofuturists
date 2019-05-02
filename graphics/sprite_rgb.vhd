/*
 *	This module reads a player's current position and draws a 20x20-pixel square centered 
 *  around it using logical constraints. 
 *
 *  Inputs:
 *    color  - The 6-bit RRGGBB color code to draw the numbers in.
 *
 *    pos_row/col - Player's current position on the screen. (479,639) is bottom-right.
 *		vga_row/col - The current row and column of the VGA scanning process. Can be up to 
 *    							525/800. Do not try to draw anything outside of 480/640 pixels.
 *
 *  Outputs:
 *		sprite_on - Flag to indicate to the renderer whether the square is being drawn.
 *		rgb_o     - The 6-bit RRGGBB color code associated with the current vga_row/col.
 *  
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sprite_rgb is
  port(
		color     : in  std_logic_vector(5 downto 0);
    
		vga_row   : in  unsigned(9 downto 0);
		vga_col   : in  unsigned(9 downto 0);
		pos_row   : in  unsigned(9 downto 0);
		pos_col   : in  unsigned(9 downto 0);
    
		sprite_on : out std_logic;
    rgb_o     : out std_logic_vector(5 downto 0)
  );
end sprite_rgb;

architecture synth of sprite_rgb is

begin
  sprite_on <= '0' when rgb_o = "000000" else '1';
 	 
	rgb_o <= color when vga_col > pos_col - 10d"10" and vga_col < pos_col + 10d"10" and 
											vga_row > pos_row - 10d"10" and vga_row < pos_row + 10d"10"
			else "000000"; -- Display black for any pixel not defined above
end;