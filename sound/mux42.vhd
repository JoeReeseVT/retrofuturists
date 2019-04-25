library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux42 is 
	port (
		d : in std_logic_vector(3 downto 0);
		s : in std_logic_vector(1 downto 0);
		y : out std_logic
	);
end mux42;

architecture synth of mux42 is
begin

y <= d(0) when (s(1) = 0 and s(0) = 0) else
	 d(1) when (s(1) = 0 and s(0) = 1) else
	 d(2) when (s(1) = 1 and s(0) = 0) else
	 d(3);
	 
end;
