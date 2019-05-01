/*
 *	Velocity logic module. Modifies player's current velocity based on user inputs. If the
 *  fire button is not held, decelerates the player to a stop. If the fire button is held 
 *  and no direction is being input, maintains current velocity, unless off-track, in which
 *  case decelerates the player to a stop. If a direction (8 possible) is being pushed while 
 *	fire is held, gradually brings the player's velocity to that direction. If holding fire
 *  and a direction while off-track, the player's max speed is limited significantly.
 *  
 *  Inputs:
 *  	clk       - Clock governing the frequency with which velocity updates. Effectively,
 *					      determines the apparent rate of acceleration and deceleration.
 *		u/d/l/r/f - Button inputs corresponding to the switches on atari-style joysticks.
 *    off-trk   - Flag determining whether the player is currently outside the bounds of
 *								the track, as determined by the find_track module.
 *
 *	Outputs:
 *		vel_x/y	- Player's current velocity componenets. Up/down and left/right range from
 *							-7/+7 normally, or -1/+1 when off_track.
 *
 */


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity velocity is
  port(
	  clk     : in  std_logic; -- 30 Hz
   
 	  u       : in  std_logic; -- Up button
		d       : in  std_logic; -- Down button
		l       : in  std_logic; -- Left button
		r       : in  std_logic; -- Right button
		f       : in  std_logic; -- Fire button
		
		off_trk : in  std_logic; -- rgb_o(4) from the track rgb output
    
		vel_x   : out signed(3 downto 0) := 4d"0";
		vel_y   : out signed(3 downto 0) := 4d"0"
  );
end velocity;

architecture synth of velocity is

signal peak_x : signed(3 downto 0); -- 4-bit signed -> min -8, max 7
signal peak_y : signed(3 downto 0);

begin
  process (clk) begin
	  if rising_edge(clk) then
		
		  /* If no direction inputs, preserve existing velocity. */
			if (not u) and (not d) and (not l) and (not r) then
			  if f then
				  if off_trk then
					  peak_x <= 4d"0";
						peak_y <= 4d"0";
					else
						peak_x <= vel_x;
						peak_y <= vel_y;
					end if;
				else
					peak_x <= 4d"0";
					peak_y <= 4d"0";
				end if;
			
			/* Otherwise, we want to set some peak velocity depending on inputs. */
			elsif u or d or l or r then
			  if f then 
					
					/* Vertical component */
					if u then
						if off_trk then
						  peak_y <= to_signed(-1, 4);
						else
						  peak_y <= to_signed(-7, 4);
						end if;	
					elsif d then
						if off_trk then
						  peak_y <= to_signed(1, 4);
						else
							peak_y <= to_signed(7, 4);
						end if;
					else
					  peak_y <= 4d"0";
					end if;
					
					/* Horizontal component */
					if l then
						if off_trk then
						  peak_x <= to_signed(-1, 4);
						else
							peak_x <= to_signed(-7, 4);
						end if;
					elsif r then
						if off_trk then
						  peak_x <= to_signed(1, 4);
						else
							peak_x <= to_signed(7, 4);
						end if;	
					else 
						peak_x <= 4d"0";
					end if;
					
				else -- When not holding f, we want to decelerate to zero.
				  peak_x <= 4d"0";
					peak_y <= 4d"0";
				end if; 
			end if; 
		
			/* Each tick while button is held, alter velocity towards the peak vector. */
			if vel_x < peak_x then
				vel_x <= vel_x + 4d"1";
			elsif vel_x > peak_x then
				vel_x <= vel_x - 4d"1";
			else 
				vel_x <= vel_x;
			end if;
		
			if vel_y < peak_y then
				vel_y <= vel_y + 4d"1";
			elsif vel_y > peak_y then
				vel_y <= vel_y - 4d"1";
			else 
				vel_y <= vel_y;
			end if;
				
    end if;    
  end process;  
end;
