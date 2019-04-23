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

signal clk : std_logic;
signal counter : unsigned(16 downto 0) := 17b"0"; 
signal notesIn : std_logic_vector(16 downto 0) := 17b"0";

begin
clkSignal : HSOSC
port map('1', '1', clk);

process(clk) is
begin
	notesIn <= "11101111001010001" when (G4 = '0') else
			   "11010101000100011" when (A4 = '0') else
			   "10111101110001110" when (B4 = '0') else
			   "10110011010000010" when (C5 = '0') else
			   "10011111101101100" when (D5 = '0');
	if counter = notesIn then
		counter <= '0';
		outWave <= not outWave;
	else
		counter <= counter + '1';
	end if;
end process;
end;
