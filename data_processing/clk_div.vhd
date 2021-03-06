/*  
 *  Counter module to divide the 60 Hz vsync down to 30 Hz for use
 *	by the velocity module. 
 *
 *	Input:
 *		clk60 - 60 Hz vsync signal.
 *
 *	Output:
 *		clk30 - 30 Hz output clock.
 *  
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clk_div is
  port(
	  clk60 : in  std_logic;
		clk30 : out std_logic
	);
end clk_div;

architecture synth of clk_div is

signal count : unsigned(1 downto 0); 

begin
  process (clk60) begin 
	  if rising_edge(clk60) then
		
			if count = 2d"2" then
				count <= 2d"0";
				clk30 <= not clk30;
			else
				count <= count + 2d"1";
			end if;
			
		end if;
	end process;
end;
