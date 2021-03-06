/*
 *	Generates a two-color racetrack image using logical constraints on the current row/col
 *	of VGA display scanning. The constraints were generated in C++ (bmp_to_vhd).
 *
 *  This is a very logically costly way of handling graphics, downside of not having to use
 *	any memory modules for graphics data.
 *
 *  Inputs:
 *		vga_row/col - The current row and column of the VGA scanning process. Can be up to 
 *    							525/800. Do not try to draw anything outside of 480/640 pixels.
 *
 *  Outputs:
 *		rgb_o - The 6-bit RRGGBB color code associated with the current vga_row/col.
 *  
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity track_rgb is
  port(
    vga_row : in  unsigned(9 downto 0);
		vga_col : in  unsigned(9 downto 0);
		
    rgb_o   : out std_logic_vector(5 downto 0)
  );
end track_rgb;

architecture synth of track_rgb is

begin
  rgb_o <= "000000" when
		((vga_row >= 10d"100" and vga_row < 10d"104") and (vga_col >= 10d"384" and vga_col < 10d"544")) or
		((vga_row >= 10d"104" and vga_row < 10d"108") and (vga_col >= 10d"372" and vga_col < 10d"584")) or
		((vga_row >= 10d"108" and vga_row < 10d"112") and (vga_col >= 10d"348" and vga_col < 10d"584")) or
		((vga_row >= 10d"112" and vga_row < 10d"116") and (vga_col >= 10d"336" and vga_col < 10d"596")) or
		((vga_row >= 10d"116" and vga_row < 10d"120") and (vga_col >= 10d"108" and vga_col < 10d"216")) or
		((vga_row >= 10d"116" and vga_row < 10d"120") and (vga_col >= 10d"336" and vga_col < 10d"596")) or
		((vga_row >= 10d"120" and vga_row < 10d"124") and (vga_col >= 10d"96" and vga_col < 10d"228")) or
		((vga_row >= 10d"120" and vga_row < 10d"124") and (vga_col >= 10d"324" and vga_col < 10d"604")) or
		((vga_row >= 10d"124" and vga_row < 10d"128") and (vga_col >= 10d"84" and vga_col < 10d"228")) or
		((vga_row >= 10d"124" and vga_row < 10d"128") and (vga_col >= 10d"324" and vga_col < 10d"604")) or
		((vga_row >= 10d"128" and vga_row < 10d"132") and (vga_col >= 10d"72" and vga_col < 10d"240")) or
		((vga_row >= 10d"128" and vga_row < 10d"132") and (vga_col >= 10d"312" and vga_col < 10d"604")) or
		((vga_row >= 10d"132" and vga_row < 10d"136") and (vga_col >= 10d"60" and vga_col < 10d"248")) or
		((vga_row >= 10d"132" and vga_row < 10d"136") and (vga_col >= 10d"312" and vga_col < 10d"612")) or
		((vga_row >= 10d"136" and vga_row < 10d"140") and (vga_col >= 10d"60" and vga_col < 10d"248")) or
		((vga_row >= 10d"136" and vga_row < 10d"140") and (vga_col >= 10d"304" and vga_col < 10d"612")) or
		((vga_row >= 10d"140" and vga_row < 10d"144") and (vga_col >= 10d"60" and vga_col < 10d"260")) or
		((vga_row >= 10d"140" and vga_row < 10d"144") and (vga_col >= 10d"304" and vga_col < 10d"612")) or
		((vga_row >= 10d"144" and vga_row < 10d"148") and (vga_col >= 10d"52" and vga_col < 10d"260")) or
		((vga_row >= 10d"144" and vga_row < 10d"148") and (vga_col >= 10d"296" and vga_col < 10d"612")) or
		((vga_row >= 10d"148" and vga_row < 10d"152") and (vga_col >= 10d"52" and vga_col < 10d"260")) or
		((vga_row >= 10d"148" and vga_row < 10d"152") and (vga_col >= 10d"296" and vga_col < 10d"612")) or
		((vga_row >= 10d"152" and vga_row < 10d"156") and (vga_col >= 10d"52" and vga_col < 10d"260")) or
		((vga_row >= 10d"152" and vga_row < 10d"156") and (vga_col >= 10d"296" and vga_col < 10d"612")) or
		((vga_row >= 10d"156" and vga_row < 10d"160") and (vga_col >= 10d"44" and vga_col < 10d"260")) or
		((vga_row >= 10d"156" and vga_row < 10d"160") and (vga_col >= 10d"292" and vga_col < 10d"612")) or
		((vga_row >= 10d"160" and vga_row < 10d"164") and (vga_col >= 10d"44" and vga_col < 10d"260")) or
		((vga_row >= 10d"160" and vga_row < 10d"164") and (vga_col >= 10d"292" and vga_col < 10d"612")) or
		((vga_row >= 10d"164" and vga_row < 10d"168") and (vga_col >= 10d"36" and vga_col < 10d"260")) or
		((vga_row >= 10d"164" and vga_row < 10d"168") and (vga_col >= 10d"292" and vga_col < 10d"612")) or
		((vga_row >= 10d"168" and vga_row < 10d"172") and (vga_col >= 10d"36" and vga_col < 10d"260")) or
		((vga_row >= 10d"168" and vga_row < 10d"172") and (vga_col >= 10d"284" and vga_col < 10d"428")) or
		((vga_row >= 10d"168" and vga_row < 10d"172") and (vga_col >= 10d"492" and vga_col < 10d"612")) or
		((vga_row >= 10d"172" and vga_row < 10d"176") and (vga_col >= 10d"28" and vga_col < 10d"260")) or
		((vga_row >= 10d"172" and vga_row < 10d"176") and (vga_col >= 10d"284" and vga_col < 10d"416")) or
		((vga_row >= 10d"172" and vga_row < 10d"176") and (vga_col >= 10d"520" and vga_col < 10d"612")) or
		((vga_row >= 10d"176" and vga_row < 10d"180") and (vga_col >= 10d"28" and vga_col < 10d"260")) or
		((vga_row >= 10d"176" and vga_row < 10d"180") and (vga_col >= 10d"284" and vga_col < 10d"404")) or
		((vga_row >= 10d"176" and vga_row < 10d"180") and (vga_col >= 10d"520" and vga_col < 10d"612")) or
		((vga_row >= 10d"180" and vga_row < 10d"184") and (vga_col >= 10d"28" and vga_col < 10d"260")) or
		((vga_row >= 10d"180" and vga_row < 10d"184") and (vga_col >= 10d"284" and vga_col < 10d"392")) or
		((vga_row >= 10d"180" and vga_row < 10d"184") and (vga_col >= 10d"508" and vga_col < 10d"612")) or
		((vga_row >= 10d"184" and vga_row < 10d"188") and (vga_col >= 10d"24" and vga_col < 10d"152")) or
		((vga_row >= 10d"184" and vga_row < 10d"188") and (vga_col >= 10d"160" and vga_col < 10d"260")) or
		((vga_row >= 10d"184" and vga_row < 10d"188") and (vga_col >= 10d"284" and vga_col < 10d"380")) or
		((vga_row >= 10d"184" and vga_row < 10d"188") and (vga_col >= 10d"508" and vga_col < 10d"612")) or
		((vga_row >= 10d"188" and vga_row < 10d"192") and (vga_col >= 10d"24" and vga_col < 10d"140")) or
		((vga_row >= 10d"188" and vga_row < 10d"192") and (vga_col >= 10d"172" and vga_col < 10d"260")) or
		((vga_row >= 10d"188" and vga_row < 10d"192") and (vga_col >= 10d"284" and vga_col < 10d"380")) or
		((vga_row >= 10d"188" and vga_row < 10d"192") and (vga_col >= 10d"508" and vga_col < 10d"612")) or
		((vga_row >= 10d"192" and vga_row < 10d"196") and (vga_col >= 10d"24" and vga_col < 10d"128")) or
		((vga_row >= 10d"192" and vga_row < 10d"196") and (vga_col >= 10d"184" and vga_col < 10d"260")) or
		((vga_row >= 10d"192" and vga_row < 10d"196") and (vga_col >= 10d"284" and vga_col < 10d"372")) or
		((vga_row >= 10d"192" and vga_row < 10d"196") and (vga_col >= 10d"500" and vga_col < 10d"612")) or
		((vga_row >= 10d"196" and vga_row < 10d"200") and (vga_col >= 10d"24" and vga_col < 10d"128")) or
		((vga_row >= 10d"196" and vga_row < 10d"200") and (vga_col >= 10d"184" and vga_col < 10d"260")) or
		((vga_row >= 10d"196" and vga_row < 10d"200") and (vga_col >= 10d"284" and vga_col < 10d"372")) or
		((vga_row >= 10d"196" and vga_row < 10d"200") and (vga_col >= 10d"500" and vga_col < 10d"608")) or
		((vga_row >= 10d"200" and vga_row < 10d"204") and (vga_col >= 10d"20" and vga_col < 10d"120")) or
		((vga_row >= 10d"200" and vga_row < 10d"204") and (vga_col >= 10d"176" and vga_col < 10d"260")) or
		((vga_row >= 10d"200" and vga_row < 10d"204") and (vga_col >= 10d"284" and vga_col < 10d"364")) or
		((vga_row >= 10d"200" and vga_row < 10d"204") and (vga_col >= 10d"488" and vga_col < 10d"608")) or
		((vga_row >= 10d"204" and vga_row < 10d"208") and (vga_col >= 10d"20" and vga_col < 10d"120")) or
		((vga_row >= 10d"204" and vga_row < 10d"208") and (vga_col >= 10d"176" and vga_col < 10d"260")) or
		((vga_row >= 10d"204" and vga_row < 10d"208") and (vga_col >= 10d"284" and vga_col < 10d"364")) or
		((vga_row >= 10d"204" and vga_row < 10d"208") and (vga_col >= 10d"488" and vga_col < 10d"608")) or
		((vga_row >= 10d"208" and vga_row < 10d"212") and (vga_col >= 10d"20" and vga_col < 10d"120")) or
		((vga_row >= 10d"208" and vga_row < 10d"212") and (vga_col >= 10d"168" and vga_col < 10d"260")) or
		((vga_row >= 10d"208" and vga_row < 10d"212") and (vga_col >= 10d"284" and vga_col < 10d"364")) or
		((vga_row >= 10d"208" and vga_row < 10d"212") and (vga_col >= 10d"480" and vga_col < 10d"608")) or
		((vga_row >= 10d"212" and vga_row < 10d"216") and (vga_col >= 10d"20" and vga_col < 10d"112")) or
		((vga_row >= 10d"212" and vga_row < 10d"216") and (vga_col >= 10d"168" and vga_col < 10d"260")) or
		((vga_row >= 10d"212" and vga_row < 10d"216") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"212" and vga_row < 10d"216") and (vga_col >= 10d"480" and vga_col < 10d"604")) or
		((vga_row >= 10d"216" and vga_row < 10d"220") and (vga_col >= 10d"20" and vga_col < 10d"112")) or
		((vga_row >= 10d"216" and vga_row < 10d"220") and (vga_col >= 10d"168" and vga_col < 10d"260")) or
		((vga_row >= 10d"216" and vga_row < 10d"220") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"216" and vga_row < 10d"220") and (vga_col >= 10d"480" and vga_col < 10d"604")) or
		((vga_row >= 10d"220" and vga_row < 10d"224") and (vga_col >= 10d"20" and vga_col < 10d"104")) or
		((vga_row >= 10d"220" and vga_row < 10d"224") and (vga_col >= 10d"164" and vga_col < 10d"260")) or
		((vga_row >= 10d"220" and vga_row < 10d"224") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"220" and vga_row < 10d"224") and (vga_col >= 10d"476" and vga_col < 10d"604")) or
		((vga_row >= 10d"224" and vga_row < 10d"228") and (vga_col >= 10d"20" and vga_col < 10d"104")) or
		((vga_row >= 10d"224" and vga_row < 10d"228") and (vga_col >= 10d"164" and vga_col < 10d"260")) or
		((vga_row >= 10d"224" and vga_row < 10d"228") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"224" and vga_row < 10d"228") and (vga_col >= 10d"476" and vga_col < 10d"596")) or
		((vga_row >= 10d"228" and vga_row < 10d"232") and (vga_col >= 10d"20" and vga_col < 10d"96")) or
		((vga_row >= 10d"228" and vga_row < 10d"232") and (vga_col >= 10d"164" and vga_col < 10d"260")) or
		((vga_row >= 10d"228" and vga_row < 10d"232") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"228" and vga_row < 10d"232") and (vga_col >= 10d"476" and vga_col < 10d"596")) or
		((vga_row >= 10d"232" and vga_row < 10d"236") and (vga_col >= 10d"20" and vga_col < 10d"96")) or
		((vga_row >= 10d"232" and vga_row < 10d"236") and (vga_col >= 10d"160" and vga_col < 10d"260")) or
		((vga_row >= 10d"232" and vga_row < 10d"236") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"232" and vga_row < 10d"236") and (vga_col >= 10d"476" and vga_col < 10d"588")) or
		((vga_row >= 10d"236" and vga_row < 10d"240") and (vga_col >= 10d"20" and vga_col < 10d"96")) or
		((vga_row >= 10d"236" and vga_row < 10d"240") and (vga_col >= 10d"160" and vga_col < 10d"260")) or
		((vga_row >= 10d"236" and vga_row < 10d"240") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"236" and vga_row < 10d"240") and (vga_col >= 10d"476" and vga_col < 10d"588")) or
		((vga_row >= 10d"240" and vga_row < 10d"244") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"240" and vga_row < 10d"244") and (vga_col >= 10d"160" and vga_col < 10d"260")) or
		((vga_row >= 10d"240" and vga_row < 10d"244") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"240" and vga_row < 10d"244") and (vga_col >= 10d"476" and vga_col < 10d"576")) or
		((vga_row >= 10d"244" and vga_row < 10d"248") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"244" and vga_row < 10d"248") and (vga_col >= 10d"160" and vga_col < 10d"256")) or
		((vga_row >= 10d"244" and vga_row < 10d"248") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"244" and vga_row < 10d"248") and (vga_col >= 10d"476" and vga_col < 10d"576")) or
		((vga_row >= 10d"248" and vga_row < 10d"252") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"248" and vga_row < 10d"252") and (vga_col >= 10d"160" and vga_col < 10d"256")) or
		((vga_row >= 10d"248" and vga_row < 10d"252") and (vga_col >= 10d"288" and vga_col < 10d"360")) or
		((vga_row >= 10d"248" and vga_row < 10d"252") and (vga_col >= 10d"476" and vga_col < 10d"568")) or
		((vga_row >= 10d"252" and vga_row < 10d"256") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"252" and vga_row < 10d"256") and (vga_col >= 10d"160" and vga_col < 10d"256")) or
		((vga_row >= 10d"252" and vga_row < 10d"256") and (vga_col >= 10d"288" and vga_col < 10d"360")) or
		((vga_row >= 10d"252" and vga_row < 10d"256") and (vga_col >= 10d"476" and vga_col < 10d"568")) or
		((vga_row >= 10d"256" and vga_row < 10d"260") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"256" and vga_row < 10d"260") and (vga_col >= 10d"160" and vga_col < 10d"244")) or
		((vga_row >= 10d"256" and vga_row < 10d"260") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"256" and vga_row < 10d"260") and (vga_col >= 10d"476" and vga_col < 10d"560")) or
		((vga_row >= 10d"260" and vga_row < 10d"264") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"260" and vga_row < 10d"264") and (vga_col >= 10d"160" and vga_col < 10d"244")) or
		((vga_row >= 10d"260" and vga_row < 10d"264") and (vga_col >= 10d"284" and vga_col < 10d"360")) or
		((vga_row >= 10d"260" and vga_row < 10d"264") and (vga_col >= 10d"476" and vga_col < 10d"560")) or
		((vga_row >= 10d"264" and vga_row < 10d"268") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"264" and vga_row < 10d"268") and (vga_col >= 10d"160" and vga_col < 10d"240")) or
		((vga_row >= 10d"264" and vga_row < 10d"268") and (vga_col >= 10d"276" and vga_col < 10d"360")) or
		((vga_row >= 10d"264" and vga_row < 10d"268") and (vga_col >= 10d"476" and vga_col < 10d"560")) or
		((vga_row >= 10d"268" and vga_row < 10d"272") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"268" and vga_row < 10d"272") and (vga_col >= 10d"160" and vga_col < 10d"240")) or
		((vga_row >= 10d"268" and vga_row < 10d"272") and (vga_col >= 10d"276" and vga_col < 10d"360")) or
		((vga_row >= 10d"268" and vga_row < 10d"272") and (vga_col >= 10d"476" and vga_col < 10d"564")) or
		((vga_row >= 10d"272" and vga_row < 10d"276") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"272" and vga_row < 10d"276") and (vga_col >= 10d"160" and vga_col < 10d"240")) or
		((vga_row >= 10d"272" and vga_row < 10d"276") and (vga_col >= 10d"264" and vga_col < 10d"360")) or
		((vga_row >= 10d"272" and vga_row < 10d"276") and (vga_col >= 10d"476" and vga_col < 10d"564")) or
		((vga_row >= 10d"276" and vga_row < 10d"280") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"276" and vga_row < 10d"280") and (vga_col >= 10d"160" and vga_col < 10d"248")) or
		((vga_row >= 10d"276" and vga_row < 10d"280") and (vga_col >= 10d"252" and vga_col < 10d"360")) or
		((vga_row >= 10d"276" and vga_row < 10d"280") and (vga_col >= 10d"476" and vga_col < 10d"564")) or
		((vga_row >= 10d"280" and vga_row < 10d"284") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"280" and vga_row < 10d"284") and (vga_col >= 10d"160" and vga_col < 10d"248")) or
		((vga_row >= 10d"280" and vga_row < 10d"284") and (vga_col >= 10d"252" and vga_col < 10d"360")) or
		((vga_row >= 10d"280" and vga_row < 10d"284") and (vga_col >= 10d"476" and vga_col < 10d"572")) or
		((vga_row >= 10d"284" and vga_row < 10d"288") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"284" and vga_row < 10d"288") and (vga_col >= 10d"160" and vga_col < 10d"360")) or
		((vga_row >= 10d"284" and vga_row < 10d"288") and (vga_col >= 10d"476" and vga_col < 10d"584")) or
		((vga_row >= 10d"288" and vga_row < 10d"292") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"288" and vga_row < 10d"292") and (vga_col >= 10d"160" and vga_col < 10d"360")) or
		((vga_row >= 10d"288" and vga_row < 10d"292") and (vga_col >= 10d"480" and vga_col < 10d"584")) or
		((vga_row >= 10d"292" and vga_row < 10d"296") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"292" and vga_row < 10d"296") and (vga_col >= 10d"160" and vga_col < 10d"360")) or
		((vga_row >= 10d"292" and vga_row < 10d"296") and (vga_col >= 10d"480" and vga_col < 10d"592")) or
		((vga_row >= 10d"296" and vga_row < 10d"300") and (vga_col >= 10d"20" and vga_col < 10d"88")) or
		((vga_row >= 10d"296" and vga_row < 10d"300") and (vga_col >= 10d"160" and vga_col < 10d"360")) or
		((vga_row >= 10d"296" and vga_row < 10d"300") and (vga_col >= 10d"480" and vga_col < 10d"592")) or
		((vga_row >= 10d"300" and vga_row < 10d"304") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"300" and vga_row < 10d"304") and (vga_col >= 10d"160" and vga_col < 10d"360")) or
		((vga_row >= 10d"300" and vga_row < 10d"304") and (vga_col >= 10d"488" and vga_col < 10d"592")) or
		((vga_row >= 10d"304" and vga_row < 10d"308") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"304" and vga_row < 10d"308") and (vga_col >= 10d"160" and vga_col < 10d"360")) or
		((vga_row >= 10d"304" and vga_row < 10d"308") and (vga_col >= 10d"488" and vga_col < 10d"600")) or
		((vga_row >= 10d"308" and vga_row < 10d"312") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"308" and vga_row < 10d"312") and (vga_col >= 10d"160" and vga_col < 10d"360")) or
		((vga_row >= 10d"308" and vga_row < 10d"312") and (vga_col >= 10d"488" and vga_col < 10d"600")) or
		((vga_row >= 10d"312" and vga_row < 10d"316") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"312" and vga_row < 10d"316") and (vga_col >= 10d"164" and vga_col < 10d"352")) or
		((vga_row >= 10d"312" and vga_row < 10d"316") and (vga_col >= 10d"492" and vga_col < 10d"608")) or
		((vga_row >= 10d"316" and vga_row < 10d"320") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"316" and vga_row < 10d"320") and (vga_col >= 10d"164" and vga_col < 10d"352")) or
		((vga_row >= 10d"316" and vga_row < 10d"320") and (vga_col >= 10d"492" and vga_col < 10d"608")) or
		((vga_row >= 10d"320" and vga_row < 10d"324") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"320" and vga_row < 10d"324") and (vga_col >= 10d"164" and vga_col < 10d"352")) or
		((vga_row >= 10d"320" and vga_row < 10d"324") and (vga_col >= 10d"492" and vga_col < 10d"608")) or
		((vga_row >= 10d"324" and vga_row < 10d"328") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"324" and vga_row < 10d"328") and (vga_col >= 10d"172" and vga_col < 10d"340")) or
		((vga_row >= 10d"324" and vga_row < 10d"328") and (vga_col >= 10d"496" and vga_col < 10d"616")) or
		((vga_row >= 10d"328" and vga_row < 10d"332") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"328" and vga_row < 10d"332") and (vga_col >= 10d"172" and vga_col < 10d"340")) or
		((vga_row >= 10d"328" and vga_row < 10d"332") and (vga_col >= 10d"496" and vga_col < 10d"616")) or
		((vga_row >= 10d"332" and vga_row < 10d"336") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"332" and vga_row < 10d"336") and (vga_col >= 10d"180" and vga_col < 10d"332")) or
		((vga_row >= 10d"332" and vga_row < 10d"336") and (vga_col >= 10d"496" and vga_col < 10d"616")) or
		((vga_row >= 10d"336" and vga_row < 10d"340") and (vga_col >= 10d"20" and vga_col < 10d"92")) or
		((vga_row >= 10d"336" and vga_row < 10d"340") and (vga_col >= 10d"180" and vga_col < 10d"320")) or
		((vga_row >= 10d"336" and vga_row < 10d"340") and (vga_col >= 10d"504" and vga_col < 10d"616")) or
		((vga_row >= 10d"340" and vga_row < 10d"344") and (vga_col >= 10d"20" and vga_col < 10d"96")) or
		((vga_row >= 10d"340" and vga_row < 10d"344") and (vga_col >= 10d"180" and vga_col < 10d"320")) or
		((vga_row >= 10d"340" and vga_row < 10d"344") and (vga_col >= 10d"504" and vga_col < 10d"616")) or
		((vga_row >= 10d"344" and vga_row < 10d"348") and (vga_col >= 10d"20" and vga_col < 10d"96")) or
		((vga_row >= 10d"344" and vga_row < 10d"348") and (vga_col >= 10d"188" and vga_col < 10d"308")) or
		((vga_row >= 10d"344" and vga_row < 10d"348") and (vga_col >= 10d"516" and vga_col < 10d"616")) or
		((vga_row >= 10d"348" and vga_row < 10d"352") and (vga_col >= 10d"20" and vga_col < 10d"96")) or
		((vga_row >= 10d"348" and vga_row < 10d"352") and (vga_col >= 10d"188" and vga_col < 10d"296")) or
		((vga_row >= 10d"348" and vga_row < 10d"352") and (vga_col >= 10d"516" and vga_col < 10d"616")) or
		((vga_row >= 10d"352" and vga_row < 10d"356") and (vga_col >= 10d"20" and vga_col < 10d"100")) or
		((vga_row >= 10d"352" and vga_row < 10d"356") and (vga_col >= 10d"524" and vga_col < 10d"616")) or
		((vga_row >= 10d"356" and vga_row < 10d"360") and (vga_col >= 10d"24" and vga_col < 10d"100")) or
		((vga_row >= 10d"356" and vga_row < 10d"360") and (vga_col >= 10d"372" and vga_col < 10d"452")) or
		((vga_row >= 10d"356" and vga_row < 10d"360") and (vga_col >= 10d"524" and vga_col < 10d"616")) or
		((vga_row >= 10d"360" and vga_row < 10d"364") and (vga_col >= 10d"24" and vga_col < 10d"100")) or
		((vga_row >= 10d"360" and vga_row < 10d"364") and (vga_col >= 10d"356" and vga_col < 10d"476")) or
		((vga_row >= 10d"360" and vga_row < 10d"364") and (vga_col >= 10d"532" and vga_col < 10d"616")) or
		((vga_row >= 10d"364" and vga_row < 10d"368") and (vga_col >= 10d"24" and vga_col < 10d"104")) or
		((vga_row >= 10d"364" and vga_row < 10d"368") and (vga_col >= 10d"344" and vga_col < 10d"476")) or
		((vga_row >= 10d"364" and vga_row < 10d"368") and (vga_col >= 10d"532" and vga_col < 10d"616")) or
		((vga_row >= 10d"368" and vga_row < 10d"372") and (vga_col >= 10d"24" and vga_col < 10d"104")) or
		((vga_row >= 10d"368" and vga_row < 10d"372") and (vga_col >= 10d"332" and vga_col < 10d"488")) or
		((vga_row >= 10d"368" and vga_row < 10d"372") and (vga_col >= 10d"532" and vga_col < 10d"616")) or
		((vga_row >= 10d"372" and vga_row < 10d"376") and (vga_col >= 10d"24" and vga_col < 10d"112")) or
		((vga_row >= 10d"372" and vga_row < 10d"376") and (vga_col >= 10d"320" and vga_col < 10d"488")) or
		((vga_row >= 10d"372" and vga_row < 10d"376") and (vga_col >= 10d"540" and vga_col < 10d"616")) or
		((vga_row >= 10d"376" and vga_row < 10d"380") and (vga_col >= 10d"24" and vga_col < 10d"112")) or
		((vga_row >= 10d"376" and vga_row < 10d"380") and (vga_col >= 10d"320" and vga_col < 10d"500")) or
		((vga_row >= 10d"376" and vga_row < 10d"380") and (vga_col >= 10d"540" and vga_col < 10d"616")) or
		((vga_row >= 10d"380" and vga_row < 10d"384") and (vga_col >= 10d"24" and vga_col < 10d"124")) or
		((vga_row >= 10d"380" and vga_row < 10d"384") and (vga_col >= 10d"296" and vga_col < 10d"500")) or
		((vga_row >= 10d"380" and vga_row < 10d"384") and (vga_col >= 10d"548" and vga_col < 10d"616")) or
		((vga_row >= 10d"384" and vga_row < 10d"388") and (vga_col >= 10d"24" and vga_col < 10d"136")) or
		((vga_row >= 10d"384" and vga_row < 10d"388") and (vga_col >= 10d"272" and vga_col < 10d"500")) or
		((vga_row >= 10d"384" and vga_row < 10d"388") and (vga_col >= 10d"536" and vga_col < 10d"616")) or
		((vga_row >= 10d"388" and vga_row < 10d"392") and (vga_col >= 10d"24" and vga_col < 10d"148")) or
		((vga_row >= 10d"388" and vga_row < 10d"392") and (vga_col >= 10d"244" and vga_col < 10d"504")) or
		((vga_row >= 10d"388" and vga_row < 10d"392") and (vga_col >= 10d"524" and vga_col < 10d"616")) or
		((vga_row >= 10d"392" and vga_row < 10d"396") and (vga_col >= 10d"28" and vga_col < 10d"160")) or
		((vga_row >= 10d"392" and vga_row < 10d"396") and (vga_col >= 10d"244" and vga_col < 10d"504")) or
		((vga_row >= 10d"392" and vga_row < 10d"396") and (vga_col >= 10d"512" and vga_col < 10d"616")) or
		((vga_row >= 10d"396" and vga_row < 10d"400") and (vga_col >= 10d"28" and vga_col < 10d"160")) or
		((vga_row >= 10d"396" and vga_row < 10d"400") and (vga_col >= 10d"232" and vga_col < 10d"616")) or
		((vga_row >= 10d"400" and vga_row < 10d"404") and (vga_col >= 10d"28" and vga_col < 10d"172")) or
		((vga_row >= 10d"400" and vga_row < 10d"404") and (vga_col >= 10d"208" and vga_col < 10d"616")) or
		((vga_row >= 10d"404" and vga_row < 10d"408") and (vga_col >= 10d"32" and vga_col < 10d"184")) or
		((vga_row >= 10d"404" and vga_row < 10d"408") and (vga_col >= 10d"196" and vga_col < 10d"616")) or
		((vga_row >= 10d"408" and vga_row < 10d"412") and (vga_col >= 10d"32" and vga_col < 10d"616")) or
		((vga_row >= 10d"412" and vga_row < 10d"416") and (vga_col >= 10d"32" and vga_col < 10d"616")) or
		((vga_row >= 10d"416" and vga_row < 10d"420") and (vga_col >= 10d"36" and vga_col < 10d"616")) or
		((vga_row >= 10d"420" and vga_row < 10d"424") and (vga_col >= 10d"36" and vga_col < 10d"616")) or
		((vga_row >= 10d"424" and vga_row < 10d"428") and (vga_col >= 10d"36" and vga_col < 10d"616")) or
		((vga_row >= 10d"428" and vga_row < 10d"432") and (vga_col >= 10d"36" and vga_col < 10d"412")) or
		((vga_row >= 10d"428" and vga_row < 10d"432") and (vga_col >= 10d"420" and vga_col < 10d"612")) or
		((vga_row >= 10d"432" and vga_row < 10d"436") and (vga_col >= 10d"44" and vga_col < 10d"400")) or
		((vga_row >= 10d"432" and vga_row < 10d"436") and (vga_col >= 10d"432" and vga_col < 10d"612")) or
		((vga_row >= 10d"436" and vga_row < 10d"440") and (vga_col >= 10d"44" and vga_col < 10d"388")) or
		((vga_row >= 10d"436" and vga_row < 10d"440") and (vga_col >= 10d"432" and vga_col < 10d"612")) or
		((vga_row >= 10d"440" and vga_row < 10d"444") and (vga_col >= 10d"56" and vga_col < 10d"376")) or
		((vga_row >= 10d"440" and vga_row < 10d"444") and (vga_col >= 10d"436" and vga_col < 10d"604")) or
		((vga_row >= 10d"444" and vga_row < 10d"448") and (vga_col >= 10d"56" and vga_col < 10d"364")) or
		((vga_row >= 10d"444" and vga_row < 10d"448") and (vga_col >= 10d"436" and vga_col < 10d"604")) or
		((vga_row >= 10d"448" and vga_row < 10d"452") and (vga_col >= 10d"68" and vga_col < 10d"336")) or
		((vga_row >= 10d"448" and vga_row < 10d"452") and (vga_col >= 10d"436" and vga_col < 10d"592")) or
		((vga_row >= 10d"452" and vga_row < 10d"456") and (vga_col >= 10d"80" and vga_col < 10d"312")) or
		((vga_row >= 10d"452" and vga_row < 10d"456") and (vga_col >= 10d"448" and vga_col < 10d"592")) or
		((vga_row >= 10d"456" and vga_row < 10d"460") and (vga_col >= 10d"92" and vga_col < 10d"300")) or
		((vga_row >= 10d"456" and vga_row < 10d"460") and (vga_col >= 10d"448" and vga_col < 10d"580")) or
		((vga_row >= 10d"460" and vga_row < 10d"464") and (vga_col >= 10d"104" and vga_col < 10d"288")) or
		((vga_row >= 10d"460" and vga_row < 10d"464") and (vga_col >= 10d"460" and vga_col < 10d"568")) or
		((vga_row >= 10d"464" and vga_row < 10d"468") and (vga_col >= 10d"104" and vga_col < 10d"288")) or
		((vga_row >= 10d"468" and vga_row < 10d"472") and (vga_col >= 10d"116" and vga_col < 10d"260")) or
		((vga_row >= 10d"472" and vga_row < 10d"476") and (vga_col >= 10d"128" and vga_col < 10d"248")) 
			else "001000" when vga_row < 10d"480" and vga_col < 10d"640" 
			else "000000";
end;