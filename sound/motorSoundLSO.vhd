library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity motorSound is 
	port (
		velocity : in std_logic_vector(2 downto 0);
		up 		 : in std_logic;
		down 	 : in std_logic;
		leftBut	 : in std_logic;
		rightBut : in std_logic;
		go 		 : in std_logic;
		clk      : in std_logic;
		outWave  : out std_logic
		);
end motorSound;

architecture synth of motorSound is 

signal clk : std_logic;
signal counter : unsigned(5 downto 0) := 6b"0"; 
signal notesIn : unsigned(5 downto 0) := 6b"0";
signal addNotes : unsigned(5 downto 0) := 6b"0";
signal finalNote : unsigned(5 downto 0) := 6b"0";
begin

process(clk) is
begin
	notesIn <= 6d"26" when (up = '0') else
			   6d"23" when (down = '0') else
			   6d"0";
	addNotes <= addNotes + 6d"1" when (velocity = "001") else
			    addNotes + 6d"2" when (velocity = "010") else
		        addNotes + 6d"4" when (velocity = "011") else
			    addNotes + 6d"5" when (velocity = "100") else
			    addNotes + 6d"6" when (velocity = "101") else
		        addNotes + 6d"9" when (velocity = "110") else
		        addNotes + 6d"10" when (velocity = "111") else
			    6b"0";
	if rising_edge(clk) then
			if counter = finalNote then
				counter <= 6b"0";
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
