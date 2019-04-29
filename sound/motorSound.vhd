library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity motorSound is 
	port (
		velocity : in std_logic_vector(2 downto 0);
		up 		 : in std_logic;
		down 	 : in std_logic;
		leftBut	 : in std_logic;
		rightBut 	 : in std_logic;
		go 		 : in std_logic;
		outWave  : out std_logic
		);
end motorSound;

architecture synth of motorSound is 
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
signal notesIn : unsigned(16 downto 0) := 17b"0";
signal addNotes : unsigned(16 downto 0) := 17b"0";
signal finalNote : unsigned(16 downto 0) := 17b"0";
begin
clkSignal : HSOSC
port map('1', '1', clk);

process(clk) is
begin
	notesIn <= 17d"122449" when (up = '0') else
			   17d"109091" when (down = '0') else
			   17d"106503" when (leftBut = '0') else
			   17d"103004" when (rightBut = '0') else
			   17d"0";
	addNotes <= addNotes + 17d"1" when (velocity = "001") else
			    addNotes + 17d"2" when (velocity = "010") else
		        addNotes + 17d"4" when (velocity = "011") else
			    addNotes + 17d"8" when (velocity = "100") else
			    addNotes + 17d"16" when (velocity = "101") else
		        addNotes + 17d"32" when (velocity = "110") else
		        addNotes + 17d"64" when (velocity = "111") else
			    17b"0";
	if rising_edge(clk) then
			if counter = finalNote then
				counter <= 17b"0";
				if go = '0' then
					finalNote <= notesIn + addNotes;
					outWave <= not outWave;
				end if;
			else
				counter <= counter + '1';
			end if;
	end if;
end process;
end;
