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
		E5 : in std_logic;
		F5 : in std_logic;
		G5 : in std_logic;
		A5 : in std_logic;
		outWave : out std_logic;
		clkSig : out std_logic
		);
end squareWaveMusic;

architecture synth of squareWaveMusic is 
component HSOSC is 
generic (
	CLKHF_DIV : String := "0b00"
);
port (
	CLKHFPU : in std_logic := 'X'; --Set to 1 to power up 
	CLKHFEN : in std_logic := 'X'; --Set to 1 to enable output
	CLKHF : out std_logic := 'X' --Clock output
);
end component;

component pll is
port(
    outglobal_o: out std_logic;
    outcore_o: out std_logic;
    ref_clk_i: in std_logic;
    rst_n_i: in std_logic
);
end component;

signal clk : std_logic;
signal clkhf : std_logic;
signal counter : unsigned(14 downto 0) := 15b"0"; 
signal notesIn : unsigned(14 downto 0) := 15b"0";
signal global : std_logic;

begin
clkSignal : HSOSC port map('1', '1', clkhf);
pll_1 : pll port map(clk, global, clkhf, '1');

process(clk) is
begin
	clkSig <= clk;
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
	if rising_edge(clk) then
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
