library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity score_rgb is 
	port(
		color : in std_logic_vector(5 downto 0);
		score : in unsigned(2 downto 0);
    vga_row, vga_col : in unsigned(9 downto 0);
		score_on : out std_logic;
		rgb_o : out std_logic_vector(5 downto 0)
	);
end score_rgb;

architecture synth of score_rgb is

begin
  score_on <= '1' when rgb_o(5) else '0';
	rgb_o <= color when score = 3d"0" and
		(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"484" and vga_col < 10d"496")) or
		((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
		((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
		((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"476" and vga_col < 10d"484")) or
		((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
		((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"496" and vga_col < 10d"504")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"496" and vga_col < 10d"504")) or
		((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
		((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"496" and vga_col < 10d"504")) or
		((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
		((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"496" and vga_col < 10d"504")) or
		((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"476" and vga_col < 10d"484")) or
		((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
		((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"484" and vga_col < 10d"496"))) else
					color when score = 3d"1" and
		(((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"480" and vga_col < 10d"492")) or
		((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
		((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
		((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
		((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
		((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
		((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"480" and vga_col < 10d"500"))) else
					color when score = 3d"2" and
		(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"484" and vga_col < 10d"492")) or
		((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
		((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
		((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
		((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"488" and vga_col < 10d"492")) or
		((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"484" and vga_col < 10d"492")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"480" and vga_col < 10d"488")) or
		((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"480" and vga_col < 10d"500"))) else
					color when score = 3d"3" and
		(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"480" and vga_col < 10d"496")) or
		((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
		((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"484" and vga_col < 10d"496")) or
		((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
		((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
		((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"480" and vga_col < 10d"496"))) else
					color when score = 3d"4" and
		(((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"488" and vga_col < 10d"496")) or
		((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"488" and vga_col < 10d"496")) or
		((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"484" and vga_col < 10d"488")) or
		((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
		((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"476" and vga_col < 10d"484")) or
		((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
		((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
		((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
		((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"476" and vga_col < 10d"504")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"492" and vga_col < 10d"496")) or
		((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"492" and vga_col < 10d"496"))) else
					color when score = 3d"5" and
		(((vga_row >= 10d"12" and vga_row < 10d"16") and (vga_col >= 10d"480" and vga_col < 10d"500")) or
		((vga_row >= 10d"16" and vga_row < 10d"20") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
		((vga_row >= 10d"20" and vga_row < 10d"24") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
		((vga_row >= 10d"24" and vga_row < 10d"28") and (vga_col >= 10d"480" and vga_col < 10d"492")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"480" and vga_col < 10d"484")) or
		((vga_row >= 10d"28" and vga_row < 10d"32") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
		((vga_row >= 10d"32" and vga_row < 10d"36") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"36" and vga_row < 10d"40") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"40" and vga_row < 10d"44") and (vga_col >= 10d"496" and vga_col < 10d"500")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"476" and vga_col < 10d"480")) or
		((vga_row >= 10d"44" and vga_row < 10d"48") and (vga_col >= 10d"492" and vga_col < 10d"500")) or
		((vga_row >= 10d"48" and vga_row < 10d"52") and (vga_col >= 10d"480" and vga_col < 10d"496"))) else
					"000000";
end;
