/*  
 *  Module to handle just the velocity part of position/velocity
 *
 *  Each combination of buttons will determine a peak velocity in each axis. If you push left, peak is (-7, 0). 
 *  If you push up and right, peak is (7, -7). The current velocity in each axis is compared to the respective 
 *  peak velocity. If current is lower, increase. if current is higher, decrease. This makes it such that pushing 
 *  a direction on the joystick will cause the car to gradually adjust to go that direction, rather than suddenly 
 *  changing velocity.
 *
 *  Velocity uses a slower clock than position so that the change appears more gradual. Otherwise the acceleration
 *  looks basically instantaneous.
 *  
 *  Author(s):
 *    Joe
 *   
 *  Version: 0.2.0
 *  Updated: 27 Apr 2019 by Joe
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity velocity is
  port(
	  clk           : in  std_logic; -- We want velocity to update kinda slowly
    u, d, l, r, f : in  std_logic; 
		off_track     : in  std_logic; -- rgb_o(4) from the track rgb output
    vel_x, vel_y  : out signed(3 downto 0) := 4d"0"
    );
end velocity;

architecture synth of velocity is

signal peak_x, peak_y : signed(3 downto 0); -- 4-bit signed -> min -8, max 7

begin
  process (clk) begin
	  if rising_edge(clk) then
		
		
		  /* If we let go of the direction, we want to preserve what direction we were going. */
		  if u and (not d) then
			  if off_track then 
					peak_y <= to_signed(-1, 4);
				else
					peak_y <= to_signed(-7, 4);
				end if;
		  elsif d and (not u) then
				if off_track then
					peak_y <= to_signed(1, 4);
				else
					peak_y <= to_signed(7, 4);
				end if;
			else 
  			peak_y <= vel_y;
			end if;
		  
			if l and (not r) then
			  if off_track then
					peak_x <= to_signed(-1, 4);
				else
					peak_x <= to_signed(-7, 4);
				end if;
		  elsif r and (not l) then
				if off_track then
					peak_x <= to_signed(1, 4);
				else
					peak_x <= to_signed(7, 4);
				end if;
			else 
				peak_x <= vel_x;
			end if;
		
		  /* 
			 *  If we hold fire, we want to accelerate the car towards peak direction. 
			 *  If we release fire, we want to decelereate to 0. 
			 */
		  if f then
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

			else -- if f
				if vel_x < 4d"0" then
					vel_x <= vel_x + 4d"1";
				elsif vel_x > 4d"0" then
					vel_x <= vel_x - 4d"1";
				else 
					vel_x <= vel_x;
				end if;
				
				if vel_y < 4d"0" then
					vel_y <= vel_y + 4d"1";
				elsif vel_y > 4d"0" then
					vel_y <= vel_y - 4d"1";
				else 
					vel_y <= vel_y;
				end if;
				
			end if; -- if f	
    end if;    
  end process;  
end;
