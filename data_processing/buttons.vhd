/*  
 *  Logic to keep track of/modify car position and velocity
 *  
 *  Author(s) :
 *    Alejandro
 *    Joe
 *
 *  Version: 0.1.0
 *  Updated: 15 Apr 2019 by Joe
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buttons is
  port(
    clk : in  std_logic; -- 60 Hz (vsync); may reduce this 
    u, d, l, r, f : in std_logic; -- up, down, left, right, fire; active HIGH
    row : out unsigned(9 downto 0) := 10d"240";
    col : out unsigned(9 downto 0) := 10d"320"
  );
end buttons;

architecture synth of buttons is

type state_t is (init, run);    -- FSM with only two states
signal state : state_t := init;

-- Using signed/unsigned didn't work, integers seem to work
signal vert  : integer; --(3 downto 0) := 4d"0";
signal horiz : integer; --signed(3 downto 0) := 4d"0";

begin        
  process (clk) begin
    if rising_edge(clk) then    
      case state is
        when init =>
          row <= 10d"240";
          col <= 10d"320";
          if u or d or l or r or f then
            state <= run;
          else 
            state <= init;
          end if;
        when run =>        
          if f then
  
            if u then 
              if vert > -7 then
                vert <= vert - 1; --4d"1";
              else 
                vert <= vert;
              end if;
            end if;

            if d then 
              if vert < 7 then
                vert <= vert + 1; --4d"1";
              else 
                vert <= vert;
              end if;        
            end if;

            if l then 
              if horiz > -7 then
                horiz <= horiz - 1; --4d"1";
              else 
                horiz <= horiz;
              end if;
            end if;
                    
            if r then 
              if horiz < 7 then
                horiz <= horiz + 1; --4d"1";
              else 
                horiz <= horiz;
              end if;
            end if;
        
          else 
            if vert < 0 then
              vert <= vert + 1;
            elsif vert > 0 then
              vert <= vert - 1;
            else 
              vert <= vert;        
            end if;                            

            if horiz < 0 then
              horiz <= horiz + 1;
            elsif horiz > 0 then
              horiz <= horiz - 1;
            else 
              horiz <= horiz;        
            end if;

          end if; -- if f
                    
/* Need to deal with screen wrapping. First attempt failed because we forgot we need
   to wrap differently depending on if we're hitting the left or right edge. Handle
     it by using velocities?
*/

--                    if row > 10d"479" then
--                      row <= 10d"0";
--                    else                    
        if vert < 0 then
          row <= row - to_unsigned(abs(vert), 4);        
        else 
          row <= row + to_unsigned(abs(vert), 4);
        end if;
--                    end if;
                    
--                    if col > 10d"639" then
--                      col <= "0";
--                    else
        if horiz < 0 then
          col <= col - to_unsigned(abs(horiz), 4);
        else 
          col <= col + to_unsigned(abs(horiz), 4);
        end if;        
--           end if;
                
        state <= run;
      end case;
    end if;
  end process;
end;



