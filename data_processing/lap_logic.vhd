library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lap_logic is
  port(
		clk			: in std_logic;
		pos_col : in unsigned(9 downto 0);
		pos_row : in unsigned(9 downto 0);
    score 	: out  unsigned(2 downto 0) := 3d"5"
  );
end lap_logic;

architecture synth of lap_logic is

type STATE is (HALF, LAST);  
signal s : STATE := HALF;

begin 
process(clk) begin
  if rising_edge(clk) then 
		if score = 3d"5" then 
			score <= 3d"0";
		else
			score <= score;
		end if;
		if s = HALF then 
			if pos_row > 10d"260" and pos_row < 10d"220" and pos_col > 10d"0" and pos_col < 10d"100" then
				s <= LAST;
			else
				s <= HALF;
			end if;
		end if;
		if s <= LAST then
			if pos_row > 10d"260" and pos_row < 10d"220" and pos_col > 10d"540" and pos_col < 10d"640" then
				score <= score + 3d"1";
				s <= HALF;
			else 
				s <= LAST;
			end if;
		end if;
	end if;
end process;
end;
