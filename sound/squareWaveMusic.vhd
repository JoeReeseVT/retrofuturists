library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity squareWaveMusic is 
	port (
	  clk25 : in std_logic;
		G4 : in std_logic;
		A4 : in std_logic;
		B4 : in std_logic;
		C5 : in std_logic;
		D5 : in std_logic;
		E5 : in std_logic;
		F5 : in std_logic;
		G5 : in std_logic;
		A5 : in std_logic;
		outWave : out std_logic
	);
end squareWaveMusic;

architecture synth of squareWaveMusic is 

signal counter : unsigned(14 downto 0) := 15b"0"; 
signal notesIn : unsigned(14 downto 0) := 15b"0";
signal global : std_logic;

begin

process(clk25) is
begin
	notesIn <= 15d"32048" when (G4 = '1') else
						 15d"28551" when (A4 = '1') else 
						 15d"26949" when (B4 = '1') else -- B flat
						 15d"24009" when (C5 = '1') else
						 15d"21389" when (D5 = '1') else
						 15d"19056" when (E5 = '1') else 
						 15d"17986" when (F5 = '1') else
						 15d"16024" when (G5 = '1') else
						 15d"14276" when (A5 = '1') else 
						 15d"0";
	if rising_edge(clk25) then
		if counter = notesIn then
			if notesIn /= 0 then
				counter <= 15b"0";
				outWave <= not outWave;
			end if;
		else
			counter <= counter + '1';
		end if;
	end if;
end process;
end;
