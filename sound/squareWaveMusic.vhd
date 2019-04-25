library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity squareWaveMusic is 
	port (
		G4 : in std_logic;
		A4 : in std_logic;
		B4 : in std_logic;
		C5 : in std_logic;
		D5 : in std_logic;
		outWave : out std_logic
		);
end squareWaveMusic;

architecture synth of squareWaveMusic is 
component HSOSC is 
generic (
CLKHF_DIV : String := "0b00");
port (
	CLKHFPU : in std_logic := 'X'; --Set to 1 to power up 
	CLKHFEN : in std_logic := 'X'; --Set to 1 to enable output
	CLKHF : out std_logic := 'X' --Clock output
);
end component;

component mux42 is 
port (
		d : in std_logic_vector(3 downto 0);
		s : in std_logic_vector(1 downto 0);
		y : out std_logic
);
end component;

signal clk : std_logic;
signal counter : unsigned(17 downto 0) := 18b"0"; 
signal notesIn : std_logic_vector(3 downto 0);
signal sel : std_logic_vector(1 downto 0);

begin
clkSignal : HSOSC
port map('1', '1', clk);

noteOut : mux42
port map(notesIn, sel, outWave);

process(clk) is
begin
	if rising_edge(clk) then
		counter <= counter + '1'
	end if;
	notesIn <= 
	
end process;
end;
