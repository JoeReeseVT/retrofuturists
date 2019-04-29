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
	  reset        : in std_logic;
	  player       : in  std_logic;
	  clk_main     : in  std_logic; -- fixed speed (really just for initializing)
    clk_x, clk_y : in  std_logic; -- variable speed
		neg_x, neg_y : in  std_logic;
    row : out unsigned(9 downto 0) := 10d"240";
    col : out unsigned(9 downto 0) := 10d"320"
  );
end position;

architecture synth of position is

signal count : unsigned(2 downto 0); -- Count to 7 for the init period
--signal init  : std_logic := '1';

begin        
/*
  process (clk_main) begin
		if rising_edge(clk_main) then
		  if init then
			  init <= '0';
			end if;
	  end if;
	end process;
*/

  process (clk_x, reset) begin
		if not reset then
			  if player then
					col <= 10d"70";
				else
				  col <= 10d"30";
				end if;
    elsif rising_edge(clk_x) then 
--				init <= '0';
				if col > 10d"831" then -- If we went off the left edge of the screen
					col <= 10d"639";
				elsif col > 10d"639" and col < 10d"832" then -- If we went off the right edge of the screen
					col <= 10d"0";
				else 
					if neg_x then
						col <= col - 10d"1";
					else
						col <= col + 10d"1";
					end if;
				end if;
		  end if;
	end process;
	
	process (clk_y, reset) begin
		if not reset then
				row <= 10d"310"; 
    elsif rising_edge(clk_y) then 
				if row > 10d"751" then -- If we went off the top edge of the screen
					row <= 10d"479";
				elsif row > 10d"479" and row < 10d"752" then -- If we went off the bottom edge of the screen
					row <= 10d"0";
				else 
					if neg_y then
						row <= row - 10d"1";
					else
						row <= row + 10d"1";
					end if;
				end if;	
    end if;
  end process;
end;



