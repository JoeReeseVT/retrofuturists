/*  
 *  Module to handle just the position part of position/velocity
 * 
 *  Includes logic to wrap around the screen if we go out of the visible range. Works by converting 
 *  signed velocity to its unsigned absolute value, so that we can either add to or subtract from the 
 *  current position in each axis based on the sign of the velocity.
 *  
 *  Author(s):
 *    Alejandro
 *    Joe
 *
 *  Version: 0.2.0
 *  Updated: 16 Apr 2019 by Joe
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity position is
  port(
    clk : in  std_logic; 
		vel_x, vel_y : in signed(3 downto 0);
    row : out unsigned(9 downto 0) := 10d"240";
    col : out unsigned(9 downto 0) := 10d"320"
  );
end position;

architecture synth of position is

type state_t is (init, run);  
signal state : state_t := init;
signal count : unsigned(3 downto 0); -- Count to 7 for the init period

signal spd_x, spd_y : unsigned(2 downto 0); -- These hold the "absolute value" of the signed velocity
signal tmp_x, tmp_y : unsigned(3 downto 0); -- Used in the conversion from signed to unsigned

begin        

tmp_x <= unsigned(abs(vel_x));
spd_x <= tmp_x(2 downto 0);

tmp_y <= unsigned(abs(vel_y));
spd_y <= tmp_y(2 downto 0);

  process (clk) begin
    if rising_edge(clk) then 
		  case state is
			  when init =>
				  row <= 10d"240";
					col <= 10d"320";
					count <= count + 4d"1";
					if count < 4d"7" then
						state <= init;
					else
					  state <= run;
					end if;
					
				when run =>
					state <= run;
					
					if col > 10d"831" then -- If we went off the left edge of the screen
						col <= 10d"639";
					elsif col > 10d"639" and col < 10d"832" then -- If we went off the right edge of the screen
						col <= 10d"0";
					else  
						if vel_x < 4d"0" then
							col <= col - spd_x;
						else 
							col <= col + spd_x;
						end if;
					end if;
					
					if row > 10d"751" then -- If we went off the top edge of the screen
						row <= 10d"479";
					elsif row > 10d"479" and row < 10d"752" then -- If we went off the bottom edge of the screen
						row <= 10d"0";
					else 
						if vel_y < 4d"0" then
							row <= row - spd_y;
						else
							row <= row + spd_y;
						end if;
					end if;			
					
			end case;
    end if;
  end process;
end;



