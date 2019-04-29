library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lap_logic is
  port(
		clk			: in  std_logic;
		pos_col : in  unsigned(9 downto 0);
		pos_row : in  unsigned(9 downto 0);
    score 	: out unsigned(2 downto 0) := 3d"0"
--		state_o : out std_logic
  );
end lap_logic;

architecture synth of lap_logic is

type STATE is (HALF, LAST);  
signal s : STATE := HALF;

begin 
process(clk) begin
  if rising_edge(clk) then 		
		if s = HALF then 
--		  state_o <= '1';
		  score <= score;
			if pos_row > 10d"220" and pos_row < 10d"260" and pos_col > 10d"0" and pos_col < 10d"100" then
				s <= LAST;
			else
				s <= HALF;
			end if;
		end if;
		
		if s = LAST then
--		  state_o <= '0';
	    score <= score;
			if pos_row > 10d"220" and pos_row < 10d"260" and pos_col > 10d"540" and pos_col < 10d"640" then
			  if score = 3d"5" then
				  score <= 3d"0";
				else
				  score <= score + 3d"1";
				end if;
				s <= HALF;
			else 
				s <= LAST;
			end if;
		end if;
	end if;
end process;
end;
