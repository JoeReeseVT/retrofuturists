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
			if (not u) and (not d) and (not l) and (not r) then
			  if f then
				  if off_track then
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
			elsif u or d or l or r then
			  if f then 
					if u then
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
					  peak_y <= 4d"0";
					end if;
					
					if l then
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
						peak_x <= 4d"0";
					end if;
					
				else -- if not f
				  peak_x <= 4d"0";
					peak_y <= 4d"0";
				end if; -- if f
			end if; -- if no buttons
		
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
