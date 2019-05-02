library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity song is
	port (
	  clk25 : in std_logic;
		wave : out std_logic
	);
end song;
	
architecture synth of song is 
component squareWaveMusic is
port (	  clk25 : in std_logic;
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
end component;

signal counter : unsigned(23 downto 0) := 24b"0"; 
signal noteCount : unsigned(6 downto 0) := 7b"0";

constant A2 : std_logic_vector(95 downto 0):= "000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"100000"&"000000"&"000000"&"000000";
constant G2 : std_logic_vector(95 downto 0):= "000000"&"000000"&"000000"&"000000"&"000000"&"111000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"010000"&"000000"&"010000"&"000000";
constant F : std_logic_vector(95 downto 0) := "000000"&"000000"&"000001"&"000000"&"000000"&"000000"&"101000"&"101101"&"000000"&"000000"&"000000"&"000011"&"001000"&"000011"&"001000"&"110000";
constant E : std_logic_vector(95 downto 0) := "000000"&"000000"&"000100"&"000000"&"000000"&"000111"&"010101"&"000000"&"000000"&"000000"&"000000"&"001100"&"000100"&"001100"&"100100"&"000000";
constant D : std_logic_vector(95 downto 0) := "001001"&"001111"&"000000"&"100011"&"000111"&"000000"&"000000"&"000000"&"000000"&"100000"&"000011"&"000000"&"000000"&"010000"&"000001"&"001100";
constant C : std_logic_vector(95 downto 0) := "010000"&"000000"&"010000"&"010000"&"111000"&"000000"&"000000"&"000000"&"000000"&"000001"&"001100"&"000000"&"000000"&"100000"&"000000"&"000000";
constant B : std_logic_vector(95 downto 0) := "100000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"010000"&"000010"&"010000"&"000000"&"000001"&"000000"&"000000"&"000000";
constant A : std_logic_vector(95 downto 0) := "000000"&"000000"&"000000"&"001000"&"000000"&"000000"&"000000"&"000000"&"101011"&"000100"&"000000"&"010000"&"000000"&"000000"&"000000"&"000011";
constant G1 : std_logic_vector(95 downto 0):= "000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000"&"011000"&"000000"&"000000"&"000000"&"000000"&"000000"&"000000";

begin
melody : squareWaveMusic
port map (clk25, G1(to_integer(noteCount)), A(to_integer(noteCount)), B(to_integer(noteCount)), C(to_integer(noteCount)), D(to_integer(noteCount)), E(to_integer(noteCount)), F(to_integer(noteCount)), G2(to_integer(noteCount)), A2(to_integer(noteCount)), wave);

process(clk25) is
begin
	if rising_edge(clk25) then
		if counter = 24d"4486607" then
			counter <= 24b"0";
			if noteCount = 7d"95" then
				noteCount <= 7b"0";
			else
				noteCount <= noteCount + '1';
			end if;
		else
			counter <= counter + '1';
		end if;
	end if;
end process;
end;