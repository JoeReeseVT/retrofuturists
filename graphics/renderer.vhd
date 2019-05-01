/*  
 *  Takes in several sources of graphics output and decides which to output.
 *  The logic for deciding which to display is not very deliberately written;
 *  we mostly let VHDL decide what goes on top of what, since it's ultimately 
 *  pretty inconsequential.
 *
 *  Inputs:
 *		track/sprite/score_rgb_i - The 6-bit RRGGBB color code being sent from
 *															 each respective source. Those ending in "2" 
 *															 indicate second-player data.
 *
 *    sprite/score_on - Flag indicating whether each of the signals described
 *                      above is active or not. Not scrictly necessary, but
 *											makes the logic simpler to look at.
 *
 *  Output:
 *		rgb_o - The 6-bit RRGGBB color code that will actually be output to the
 *						VGA decoder dongle.
 *
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity renderer is
  port(
    track_rgb_i   : in std_logic_vector(5 downto 0);
		
		sprite_rgb_i  : in std_logic_vector(5 downto 0);
    score_rgb_i   : in std_logic_vector(5 downto 0);
		
		sprite_rgb_i2 : in std_logic_vector(5 downto 0);
		score_rgb_i2  : in std_logic_vector(5 downto 0);
		
    sprite_on     : in std_logic;
		score_on      : in std_logic;
		
		sprite_on2    : in std_logic;
		score_on2     : in std_logic;
		
    rgb_o         : out std_logic_vector(5 downto 0)		
  );
end renderer;

architecture synth of renderer is

begin 				 
	rgb_o <= score_rgb_i   when score_on 
			else sprite_rgb_i  when sprite_on and (not score_on) 
			else score_rgb_i2  when score_on2
			else sprite_rgb_i2 when sprite_on2 and (not score_on2) 
			else track_rgb_i;
end;
