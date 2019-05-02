/*
 *	This module consists of a number of pattern-generating constraints in order to display
 *  a number on the screen corresponding to how many laps a player has completed.
 *
 *  To avoid substantial manual intervention, scores for each player are generated using 
 *  entirely different constraints. This is not an ideal solution as it is very logically
 *  inefficient compared to just "moving" the digit around, but this is the result of not 
 *  using memory for graphics rendering.
 *
 *  Currently, a weakness with the implementation is that the digits for each player aren't 
 *  identical. In some cases the differences look quite strange. This is due to the way the
 *  constraints have been generated (see the readme for bmp_to_vhd). In short, it is an 
 *  artifact of downsampling the display from 640x480 by a factor of 4. 
 *
 *  The code currently displays the digit "5" for any score >= 5.
 *
 *  Inputs:
 *		player - 0 is first player, 1 is second. Used to determine where to place the digits.
 *    color  - The 6-bit RRGGBB color code to draw the numbers in.
 *		score  - The 3-bit score whose value (up to 5) will be displayed.
 *
 *		vga_row/col - The current row and column of the VGA scanning process. Can be up to 
 *    							525/800. Do not try to draw anything outside of 480/640 pixels.
 *
 *  Outputs:
 *		score_on - Flag to indicate to the renderer whether a digit is being drawn.
 *		rgb_o    - The 6-bit RRGGBB color code associated with the current vga_row/col.
 *  
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity score_rgb is 
	port(
		player   : in  std_logic;
		color    : in  std_logic_vector(5 downto 0);
		score    : in  unsigned(2 downto 0);
    
		vga_row  : in  unsigned(9 downto 0);
		vga_col  : in  unsigned(9 downto 0);
		
		score_on : out std_logic;
		rgb_o    : out std_logic_vector(5 downto 0)
	);
end score_rgb;

architecture synth of score_rgb is

begin
  score_on <= '0' when rgb_o = "000000" else '1'; -- Flag to tell renderer when we're showing the score
	
	rgb_o <= color when player = '0' and score = 3d"0" and -- 0 digit, first player
					(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"484" and vga_col < 10d"496")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"476" and vga_col < 10d"484")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"496" and vga_col < 10d"504")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"496" and vga_col < 10d"504")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"496" and vga_col < 10d"504")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"496" and vga_col < 10d"504")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"476" and vga_col < 10d"484")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"484" and vga_col < 10d"496"))) 
					
			else color when player = '1' and score = 3d"0" and -- 0 digit, second player
					(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"164" and vga_col < 10d"176")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"160" and vga_col < 10d"164")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"160" and vga_col < 10d"164")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"164" and vga_col < 10d"176"))) 
					
			else color when player = '0' and score = 3d"1" and -- 1 digit, first player
					(((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"480" and vga_col < 10d"492")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"480" and vga_col < 10d"500")))

			else color when player = '1' and score = 3d"1" and -- 1 digit, second player
					(((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"156" and vga_col < 10d"172")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"168" and vga_col < 10d"172")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"168" and vga_col < 10d"172")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"168" and vga_col < 10d"172")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"168" and vga_col < 10d"172")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"168" and vga_col < 10d"172")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"168" and vga_col < 10d"172")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"168" and vga_col < 10d"172")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"160" and vga_col < 10d"180"))) 
					
			else color when player = '0' and score = 3d"2" and -- 2 digit, first player
					(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"484" and vga_col < 10d"492")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"484" and vga_col < 10d"492")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"480" and vga_col < 10d"488")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"480" and vga_col < 10d"500"))) 
					
			else color when player = '1' and score = 3d"2" and -- 2 digit, second player
					(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"164" and vga_col < 10d"172")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"156" and vga_col < 10d"164")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"172" and vga_col < 10d"176")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"168" and vga_col < 10d"172")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"164" and vga_col < 10d"168")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"160" and vga_col < 10d"164")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"156" and vga_col < 10d"180"))) 
					
			else color when player = '0' and score = 3d"3" and -- 3 digit, first player
					(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"480" and vga_col < 10d"496")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"484" and vga_col < 10d"496")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"480" and vga_col < 10d"496"))) 
					
			else color when player = '1' and score = 3d"3" and -- 3 digit, second player
					(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"160" and vga_col < 10d"176")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"164" and vga_col < 10d"172")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"156" and vga_col < 10d"176"))) 
					
			else color when player = '0' and score = 3d"4" and -- 4 digit, first player
					(((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"488" and vga_col < 10d"496")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"488" and vga_col < 10d"496")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"484" and vga_col < 10d"488")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"476" and vga_col < 10d"484")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"476" and vga_col < 10d"504")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"492" and vga_col < 10d"496"))) 
					
			else color when player = '1' and score = 3d"4" and -- 4 digit, second player
					(((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"168" and vga_col < 10d"176")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"168" and vga_col < 10d"176")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"164" and vga_col < 10d"168")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"172" and vga_col < 10d"176")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"160" and vga_col < 10d"164")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"172" and vga_col < 10d"176")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"156" and vga_col < 10d"164")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"172" and vga_col < 10d"176")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"172" and vga_col < 10d"176")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"156" and vga_col < 10d"184")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"172" and vga_col < 10d"176")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"172" and vga_col < 10d"176"))) 
					
			else color when player = '0' and score >= 3d"5" and -- 5 digit, first player
					(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"480" and vga_col < 10d"500")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"480" and vga_col < 10d"492")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"480" and vga_col < 10d"496"))) 
					
			else color when player = '1' and score >= 3d"5" and -- 5 digit, second player
					(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"160" and vga_col < 10d"176")) or
					((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"160" and vga_col < 10d"164")) or
					((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"160" and vga_col < 10d"164")) or
					((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"160" and vga_col < 10d"172")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"160" and vga_col < 10d"164")) or
					((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"168" and vga_col < 10d"176")) or
					((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"176" and vga_col < 10d"180")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"156" and vga_col < 10d"160")) or
					((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"172" and vga_col < 10d"180")) or
					((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"156" and vga_col < 10d"172"))) 
			
			else "000000"; -- Display black for any pixel not defined above
end;