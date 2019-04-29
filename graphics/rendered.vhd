/*  
 *  Higher-level module to take in graphics data from various 
 *  graphics sources and "decide" betwen them based on external 
 *  conditions, e.g. potition/velocity.
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

entity renderer is
  port(
    track_rgb_i, sprite_rgb_i, score_rgb_i, sprite_rgb_i2, score_rgb_i2 : in std_logic_vector(5 downto 0);
    sprite_on, score_on, sprite_on2, score_on2 : in std_logic;
    rgb_o : out std_logic_vector(5 downto 0)
		
		
  );
end renderer;

architecture synth of renderer is

begin 
/*
  rgb_o <= --score_rgb_i  when score_on else 
	         --sprite_rgb_i when sprite_on else
					 score_rgb_i2 when sprite_on2 else
					 sprite_rgb_i2 when sprite_on2 else
					 track_rgb_i;
					 */
					 
	rgb_o <= score_rgb_i  when score_on else 
	         sprite_rgb_i when sprite_on and (not score_on) else
					 score_rgb_i2  when score_on2 else 
	         sprite_rgb_i2 when sprite_on2 and (not score_on2) else
					 track_rgb_i;
  
end;
