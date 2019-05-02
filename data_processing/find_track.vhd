/*
 *	Module to read in player's position on the screen to determine if it is within
 *	the track (the black part of the background) or not. Uses the same constraints
 *	as those used to generate the background itself. If outside, outputs '1'.
 *
 *	Inputs:
 *		pos_row/col - Player's current position. (480,640) is bottom-right.
 *
 *	Output:
 *		off_track - '1' when position is outside the track constraints, else '0'.
 *
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity find_track is
  port(
	  pos_row   : in  unsigned(9 downto 0);
		pos_col   : in  unsigned(9 downto 0);
		off_track : out std_logic
  );
end find_track;

architecture synth of find_track is

begin
  off_track <= '0' when
		((pos_row >= 10d"100" and pos_row < 10d"104") and (pos_col >= 10d"384" and pos_col < 10d"544")) or
		((pos_row >= 10d"104" and pos_row < 10d"108") and (pos_col >= 10d"372" and pos_col < 10d"584")) or
		((pos_row >= 10d"108" and pos_row < 10d"112") and (pos_col >= 10d"348" and pos_col < 10d"584")) or
		((pos_row >= 10d"112" and pos_row < 10d"116") and (pos_col >= 10d"336" and pos_col < 10d"596")) or
		((pos_row >= 10d"116" and pos_row < 10d"120") and (pos_col >= 10d"108" and pos_col < 10d"216")) or
		((pos_row >= 10d"116" and pos_row < 10d"120") and (pos_col >= 10d"336" and pos_col < 10d"596")) or
		((pos_row >= 10d"120" and pos_row < 10d"124") and (pos_col >= 10d"96" and pos_col < 10d"228")) or
		((pos_row >= 10d"120" and pos_row < 10d"124") and (pos_col >= 10d"324" and pos_col < 10d"604")) or
		((pos_row >= 10d"124" and pos_row < 10d"128") and (pos_col >= 10d"84" and pos_col < 10d"228")) or
		((pos_row >= 10d"124" and pos_row < 10d"128") and (pos_col >= 10d"324" and pos_col < 10d"604")) or
		((pos_row >= 10d"128" and pos_row < 10d"132") and (pos_col >= 10d"72" and pos_col < 10d"240")) or
		((pos_row >= 10d"128" and pos_row < 10d"132") and (pos_col >= 10d"312" and pos_col < 10d"604")) or
		((pos_row >= 10d"132" and pos_row < 10d"136") and (pos_col >= 10d"60" and pos_col < 10d"248")) or
		((pos_row >= 10d"132" and pos_row < 10d"136") and (pos_col >= 10d"312" and pos_col < 10d"612")) or
		((pos_row >= 10d"136" and pos_row < 10d"140") and (pos_col >= 10d"60" and pos_col < 10d"248")) or
		((pos_row >= 10d"136" and pos_row < 10d"140") and (pos_col >= 10d"304" and pos_col < 10d"612")) or
		((pos_row >= 10d"140" and pos_row < 10d"144") and (pos_col >= 10d"60" and pos_col < 10d"260")) or
		((pos_row >= 10d"140" and pos_row < 10d"144") and (pos_col >= 10d"304" and pos_col < 10d"612")) or
		((pos_row >= 10d"144" and pos_row < 10d"148") and (pos_col >= 10d"52" and pos_col < 10d"260")) or
		((pos_row >= 10d"144" and pos_row < 10d"148") and (pos_col >= 10d"296" and pos_col < 10d"612")) or
		((pos_row >= 10d"148" and pos_row < 10d"152") and (pos_col >= 10d"52" and pos_col < 10d"260")) or
		((pos_row >= 10d"148" and pos_row < 10d"152") and (pos_col >= 10d"296" and pos_col < 10d"612")) or
		((pos_row >= 10d"152" and pos_row < 10d"156") and (pos_col >= 10d"52" and pos_col < 10d"260")) or
		((pos_row >= 10d"152" and pos_row < 10d"156") and (pos_col >= 10d"296" and pos_col < 10d"612")) or
		((pos_row >= 10d"156" and pos_row < 10d"160") and (pos_col >= 10d"44" and pos_col < 10d"260")) or
		((pos_row >= 10d"156" and pos_row < 10d"160") and (pos_col >= 10d"292" and pos_col < 10d"612")) or
		((pos_row >= 10d"160" and pos_row < 10d"164") and (pos_col >= 10d"44" and pos_col < 10d"260")) or
		((pos_row >= 10d"160" and pos_row < 10d"164") and (pos_col >= 10d"292" and pos_col < 10d"612")) or
		((pos_row >= 10d"164" and pos_row < 10d"168") and (pos_col >= 10d"36" and pos_col < 10d"260")) or
		((pos_row >= 10d"164" and pos_row < 10d"168") and (pos_col >= 10d"292" and pos_col < 10d"612")) or
		((pos_row >= 10d"168" and pos_row < 10d"172") and (pos_col >= 10d"36" and pos_col < 10d"260")) or
		((pos_row >= 10d"168" and pos_row < 10d"172") and (pos_col >= 10d"284" and pos_col < 10d"428")) or
		((pos_row >= 10d"168" and pos_row < 10d"172") and (pos_col >= 10d"492" and pos_col < 10d"612")) or
		((pos_row >= 10d"172" and pos_row < 10d"176") and (pos_col >= 10d"28" and pos_col < 10d"260")) or
		((pos_row >= 10d"172" and pos_row < 10d"176") and (pos_col >= 10d"284" and pos_col < 10d"416")) or
		((pos_row >= 10d"172" and pos_row < 10d"176") and (pos_col >= 10d"520" and pos_col < 10d"612")) or
		((pos_row >= 10d"176" and pos_row < 10d"180") and (pos_col >= 10d"28" and pos_col < 10d"260")) or
		((pos_row >= 10d"176" and pos_row < 10d"180") and (pos_col >= 10d"284" and pos_col < 10d"404")) or
		((pos_row >= 10d"176" and pos_row < 10d"180") and (pos_col >= 10d"520" and pos_col < 10d"612")) or
		((pos_row >= 10d"180" and pos_row < 10d"184") and (pos_col >= 10d"28" and pos_col < 10d"260")) or
		((pos_row >= 10d"180" and pos_row < 10d"184") and (pos_col >= 10d"284" and pos_col < 10d"392")) or
		((pos_row >= 10d"180" and pos_row < 10d"184") and (pos_col >= 10d"508" and pos_col < 10d"612")) or
		((pos_row >= 10d"184" and pos_row < 10d"188") and (pos_col >= 10d"24" and pos_col < 10d"152")) or
		((pos_row >= 10d"184" and pos_row < 10d"188") and (pos_col >= 10d"160" and pos_col < 10d"260")) or
		((pos_row >= 10d"184" and pos_row < 10d"188") and (pos_col >= 10d"284" and pos_col < 10d"380")) or
		((pos_row >= 10d"184" and pos_row < 10d"188") and (pos_col >= 10d"508" and pos_col < 10d"612")) or
		((pos_row >= 10d"188" and pos_row < 10d"192") and (pos_col >= 10d"24" and pos_col < 10d"140")) or
		((pos_row >= 10d"188" and pos_row < 10d"192") and (pos_col >= 10d"172" and pos_col < 10d"260")) or
		((pos_row >= 10d"188" and pos_row < 10d"192") and (pos_col >= 10d"284" and pos_col < 10d"380")) or
		((pos_row >= 10d"188" and pos_row < 10d"192") and (pos_col >= 10d"508" and pos_col < 10d"612")) or
		((pos_row >= 10d"192" and pos_row < 10d"196") and (pos_col >= 10d"24" and pos_col < 10d"128")) or
		((pos_row >= 10d"192" and pos_row < 10d"196") and (pos_col >= 10d"184" and pos_col < 10d"260")) or
		((pos_row >= 10d"192" and pos_row < 10d"196") and (pos_col >= 10d"284" and pos_col < 10d"372")) or
		((pos_row >= 10d"192" and pos_row < 10d"196") and (pos_col >= 10d"500" and pos_col < 10d"612")) or
		((pos_row >= 10d"196" and pos_row < 10d"200") and (pos_col >= 10d"24" and pos_col < 10d"128")) or
		((pos_row >= 10d"196" and pos_row < 10d"200") and (pos_col >= 10d"184" and pos_col < 10d"260")) or
		((pos_row >= 10d"196" and pos_row < 10d"200") and (pos_col >= 10d"284" and pos_col < 10d"372")) or
		((pos_row >= 10d"196" and pos_row < 10d"200") and (pos_col >= 10d"500" and pos_col < 10d"608")) or
		((pos_row >= 10d"200" and pos_row < 10d"204") and (pos_col >= 10d"20" and pos_col < 10d"120")) or
		((pos_row >= 10d"200" and pos_row < 10d"204") and (pos_col >= 10d"176" and pos_col < 10d"260")) or
		((pos_row >= 10d"200" and pos_row < 10d"204") and (pos_col >= 10d"284" and pos_col < 10d"364")) or
		((pos_row >= 10d"200" and pos_row < 10d"204") and (pos_col >= 10d"488" and pos_col < 10d"608")) or
		((pos_row >= 10d"204" and pos_row < 10d"208") and (pos_col >= 10d"20" and pos_col < 10d"120")) or
		((pos_row >= 10d"204" and pos_row < 10d"208") and (pos_col >= 10d"176" and pos_col < 10d"260")) or
		((pos_row >= 10d"204" and pos_row < 10d"208") and (pos_col >= 10d"284" and pos_col < 10d"364")) or
		((pos_row >= 10d"204" and pos_row < 10d"208") and (pos_col >= 10d"488" and pos_col < 10d"608")) or
		((pos_row >= 10d"208" and pos_row < 10d"212") and (pos_col >= 10d"20" and pos_col < 10d"120")) or
		((pos_row >= 10d"208" and pos_row < 10d"212") and (pos_col >= 10d"168" and pos_col < 10d"260")) or
		((pos_row >= 10d"208" and pos_row < 10d"212") and (pos_col >= 10d"284" and pos_col < 10d"364")) or
		((pos_row >= 10d"208" and pos_row < 10d"212") and (pos_col >= 10d"480" and pos_col < 10d"608")) or
		((pos_row >= 10d"212" and pos_row < 10d"216") and (pos_col >= 10d"20" and pos_col < 10d"112")) or
		((pos_row >= 10d"212" and pos_row < 10d"216") and (pos_col >= 10d"168" and pos_col < 10d"260")) or
		((pos_row >= 10d"212" and pos_row < 10d"216") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"212" and pos_row < 10d"216") and (pos_col >= 10d"480" and pos_col < 10d"604")) or
		((pos_row >= 10d"216" and pos_row < 10d"220") and (pos_col >= 10d"20" and pos_col < 10d"112")) or
		((pos_row >= 10d"216" and pos_row < 10d"220") and (pos_col >= 10d"168" and pos_col < 10d"260")) or
		((pos_row >= 10d"216" and pos_row < 10d"220") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"216" and pos_row < 10d"220") and (pos_col >= 10d"480" and pos_col < 10d"604")) or
		((pos_row >= 10d"220" and pos_row < 10d"224") and (pos_col >= 10d"20" and pos_col < 10d"104")) or
		((pos_row >= 10d"220" and pos_row < 10d"224") and (pos_col >= 10d"164" and pos_col < 10d"260")) or
		((pos_row >= 10d"220" and pos_row < 10d"224") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"220" and pos_row < 10d"224") and (pos_col >= 10d"476" and pos_col < 10d"604")) or
		((pos_row >= 10d"224" and pos_row < 10d"228") and (pos_col >= 10d"20" and pos_col < 10d"104")) or
		((pos_row >= 10d"224" and pos_row < 10d"228") and (pos_col >= 10d"164" and pos_col < 10d"260")) or
		((pos_row >= 10d"224" and pos_row < 10d"228") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"224" and pos_row < 10d"228") and (pos_col >= 10d"476" and pos_col < 10d"596")) or
		((pos_row >= 10d"228" and pos_row < 10d"232") and (pos_col >= 10d"20" and pos_col < 10d"96")) or
		((pos_row >= 10d"228" and pos_row < 10d"232") and (pos_col >= 10d"164" and pos_col < 10d"260")) or
		((pos_row >= 10d"228" and pos_row < 10d"232") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"228" and pos_row < 10d"232") and (pos_col >= 10d"476" and pos_col < 10d"596")) or
		((pos_row >= 10d"232" and pos_row < 10d"236") and (pos_col >= 10d"20" and pos_col < 10d"96")) or
		((pos_row >= 10d"232" and pos_row < 10d"236") and (pos_col >= 10d"160" and pos_col < 10d"260")) or
		((pos_row >= 10d"232" and pos_row < 10d"236") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"232" and pos_row < 10d"236") and (pos_col >= 10d"476" and pos_col < 10d"588")) or
		((pos_row >= 10d"236" and pos_row < 10d"240") and (pos_col >= 10d"20" and pos_col < 10d"96")) or
		((pos_row >= 10d"236" and pos_row < 10d"240") and (pos_col >= 10d"160" and pos_col < 10d"260")) or
		((pos_row >= 10d"236" and pos_row < 10d"240") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"236" and pos_row < 10d"240") and (pos_col >= 10d"476" and pos_col < 10d"588")) or
		((pos_row >= 10d"240" and pos_row < 10d"244") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"240" and pos_row < 10d"244") and (pos_col >= 10d"160" and pos_col < 10d"260")) or
		((pos_row >= 10d"240" and pos_row < 10d"244") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"240" and pos_row < 10d"244") and (pos_col >= 10d"476" and pos_col < 10d"576")) or
		((pos_row >= 10d"244" and pos_row < 10d"248") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"244" and pos_row < 10d"248") and (pos_col >= 10d"160" and pos_col < 10d"256")) or
		((pos_row >= 10d"244" and pos_row < 10d"248") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"244" and pos_row < 10d"248") and (pos_col >= 10d"476" and pos_col < 10d"576")) or
		((pos_row >= 10d"248" and pos_row < 10d"252") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"248" and pos_row < 10d"252") and (pos_col >= 10d"160" and pos_col < 10d"256")) or
		((pos_row >= 10d"248" and pos_row < 10d"252") and (pos_col >= 10d"288" and pos_col < 10d"360")) or
		((pos_row >= 10d"248" and pos_row < 10d"252") and (pos_col >= 10d"476" and pos_col < 10d"568")) or
		((pos_row >= 10d"252" and pos_row < 10d"256") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"252" and pos_row < 10d"256") and (pos_col >= 10d"160" and pos_col < 10d"256")) or
		((pos_row >= 10d"252" and pos_row < 10d"256") and (pos_col >= 10d"288" and pos_col < 10d"360")) or
		((pos_row >= 10d"252" and pos_row < 10d"256") and (pos_col >= 10d"476" and pos_col < 10d"568")) or
		((pos_row >= 10d"256" and pos_row < 10d"260") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"256" and pos_row < 10d"260") and (pos_col >= 10d"160" and pos_col < 10d"244")) or
		((pos_row >= 10d"256" and pos_row < 10d"260") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"256" and pos_row < 10d"260") and (pos_col >= 10d"476" and pos_col < 10d"560")) or
		((pos_row >= 10d"260" and pos_row < 10d"264") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"260" and pos_row < 10d"264") and (pos_col >= 10d"160" and pos_col < 10d"244")) or
		((pos_row >= 10d"260" and pos_row < 10d"264") and (pos_col >= 10d"284" and pos_col < 10d"360")) or
		((pos_row >= 10d"260" and pos_row < 10d"264") and (pos_col >= 10d"476" and pos_col < 10d"560")) or
		((pos_row >= 10d"264" and pos_row < 10d"268") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"264" and pos_row < 10d"268") and (pos_col >= 10d"160" and pos_col < 10d"240")) or
		((pos_row >= 10d"264" and pos_row < 10d"268") and (pos_col >= 10d"276" and pos_col < 10d"360")) or
		((pos_row >= 10d"264" and pos_row < 10d"268") and (pos_col >= 10d"476" and pos_col < 10d"560")) or
		((pos_row >= 10d"268" and pos_row < 10d"272") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"268" and pos_row < 10d"272") and (pos_col >= 10d"160" and pos_col < 10d"240")) or
		((pos_row >= 10d"268" and pos_row < 10d"272") and (pos_col >= 10d"276" and pos_col < 10d"360")) or
		((pos_row >= 10d"268" and pos_row < 10d"272") and (pos_col >= 10d"476" and pos_col < 10d"564")) or
		((pos_row >= 10d"272" and pos_row < 10d"276") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"272" and pos_row < 10d"276") and (pos_col >= 10d"160" and pos_col < 10d"240")) or
		((pos_row >= 10d"272" and pos_row < 10d"276") and (pos_col >= 10d"264" and pos_col < 10d"360")) or
		((pos_row >= 10d"272" and pos_row < 10d"276") and (pos_col >= 10d"476" and pos_col < 10d"564")) or
		((pos_row >= 10d"276" and pos_row < 10d"280") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"276" and pos_row < 10d"280") and (pos_col >= 10d"160" and pos_col < 10d"248")) or
		((pos_row >= 10d"276" and pos_row < 10d"280") and (pos_col >= 10d"252" and pos_col < 10d"360")) or
		((pos_row >= 10d"276" and pos_row < 10d"280") and (pos_col >= 10d"476" and pos_col < 10d"564")) or
		((pos_row >= 10d"280" and pos_row < 10d"284") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"280" and pos_row < 10d"284") and (pos_col >= 10d"160" and pos_col < 10d"248")) or
		((pos_row >= 10d"280" and pos_row < 10d"284") and (pos_col >= 10d"252" and pos_col < 10d"360")) or
		((pos_row >= 10d"280" and pos_row < 10d"284") and (pos_col >= 10d"476" and pos_col < 10d"572")) or
		((pos_row >= 10d"284" and pos_row < 10d"288") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"284" and pos_row < 10d"288") and (pos_col >= 10d"160" and pos_col < 10d"360")) or
		((pos_row >= 10d"284" and pos_row < 10d"288") and (pos_col >= 10d"476" and pos_col < 10d"584")) or
		((pos_row >= 10d"288" and pos_row < 10d"292") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"288" and pos_row < 10d"292") and (pos_col >= 10d"160" and pos_col < 10d"360")) or
		((pos_row >= 10d"288" and pos_row < 10d"292") and (pos_col >= 10d"480" and pos_col < 10d"584")) or
		((pos_row >= 10d"292" and pos_row < 10d"296") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"292" and pos_row < 10d"296") and (pos_col >= 10d"160" and pos_col < 10d"360")) or
		((pos_row >= 10d"292" and pos_row < 10d"296") and (pos_col >= 10d"480" and pos_col < 10d"592")) or
		((pos_row >= 10d"296" and pos_row < 10d"300") and (pos_col >= 10d"20" and pos_col < 10d"88")) or
		((pos_row >= 10d"296" and pos_row < 10d"300") and (pos_col >= 10d"160" and pos_col < 10d"360")) or
		((pos_row >= 10d"296" and pos_row < 10d"300") and (pos_col >= 10d"480" and pos_col < 10d"592")) or
		((pos_row >= 10d"300" and pos_row < 10d"304") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"300" and pos_row < 10d"304") and (pos_col >= 10d"160" and pos_col < 10d"360")) or
		((pos_row >= 10d"300" and pos_row < 10d"304") and (pos_col >= 10d"488" and pos_col < 10d"592")) or
		((pos_row >= 10d"304" and pos_row < 10d"308") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"304" and pos_row < 10d"308") and (pos_col >= 10d"160" and pos_col < 10d"360")) or
		((pos_row >= 10d"304" and pos_row < 10d"308") and (pos_col >= 10d"488" and pos_col < 10d"600")) or
		((pos_row >= 10d"308" and pos_row < 10d"312") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"308" and pos_row < 10d"312") and (pos_col >= 10d"160" and pos_col < 10d"360")) or
		((pos_row >= 10d"308" and pos_row < 10d"312") and (pos_col >= 10d"488" and pos_col < 10d"600")) or
		((pos_row >= 10d"312" and pos_row < 10d"316") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"312" and pos_row < 10d"316") and (pos_col >= 10d"164" and pos_col < 10d"352")) or
		((pos_row >= 10d"312" and pos_row < 10d"316") and (pos_col >= 10d"492" and pos_col < 10d"608")) or
		((pos_row >= 10d"316" and pos_row < 10d"320") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"316" and pos_row < 10d"320") and (pos_col >= 10d"164" and pos_col < 10d"352")) or
		((pos_row >= 10d"316" and pos_row < 10d"320") and (pos_col >= 10d"492" and pos_col < 10d"608")) or
		((pos_row >= 10d"320" and pos_row < 10d"324") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"320" and pos_row < 10d"324") and (pos_col >= 10d"164" and pos_col < 10d"352")) or
		((pos_row >= 10d"320" and pos_row < 10d"324") and (pos_col >= 10d"492" and pos_col < 10d"608")) or
		((pos_row >= 10d"324" and pos_row < 10d"328") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"324" and pos_row < 10d"328") and (pos_col >= 10d"172" and pos_col < 10d"340")) or
		((pos_row >= 10d"324" and pos_row < 10d"328") and (pos_col >= 10d"496" and pos_col < 10d"616")) or
		((pos_row >= 10d"328" and pos_row < 10d"332") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"328" and pos_row < 10d"332") and (pos_col >= 10d"172" and pos_col < 10d"340")) or
		((pos_row >= 10d"328" and pos_row < 10d"332") and (pos_col >= 10d"496" and pos_col < 10d"616")) or
		((pos_row >= 10d"332" and pos_row < 10d"336") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"332" and pos_row < 10d"336") and (pos_col >= 10d"180" and pos_col < 10d"332")) or
		((pos_row >= 10d"332" and pos_row < 10d"336") and (pos_col >= 10d"496" and pos_col < 10d"616")) or
		((pos_row >= 10d"336" and pos_row < 10d"340") and (pos_col >= 10d"20" and pos_col < 10d"92")) or
		((pos_row >= 10d"336" and pos_row < 10d"340") and (pos_col >= 10d"180" and pos_col < 10d"320")) or
		((pos_row >= 10d"336" and pos_row < 10d"340") and (pos_col >= 10d"504" and pos_col < 10d"616")) or
		((pos_row >= 10d"340" and pos_row < 10d"344") and (pos_col >= 10d"20" and pos_col < 10d"96")) or
		((pos_row >= 10d"340" and pos_row < 10d"344") and (pos_col >= 10d"180" and pos_col < 10d"320")) or
		((pos_row >= 10d"340" and pos_row < 10d"344") and (pos_col >= 10d"504" and pos_col < 10d"616")) or
		((pos_row >= 10d"344" and pos_row < 10d"348") and (pos_col >= 10d"20" and pos_col < 10d"96")) or
		((pos_row >= 10d"344" and pos_row < 10d"348") and (pos_col >= 10d"188" and pos_col < 10d"308")) or
		((pos_row >= 10d"344" and pos_row < 10d"348") and (pos_col >= 10d"516" and pos_col < 10d"616")) or
		((pos_row >= 10d"348" and pos_row < 10d"352") and (pos_col >= 10d"20" and pos_col < 10d"96")) or
		((pos_row >= 10d"348" and pos_row < 10d"352") and (pos_col >= 10d"188" and pos_col < 10d"296")) or
		((pos_row >= 10d"348" and pos_row < 10d"352") and (pos_col >= 10d"516" and pos_col < 10d"616")) or
		((pos_row >= 10d"352" and pos_row < 10d"356") and (pos_col >= 10d"20" and pos_col < 10d"100")) or
		((pos_row >= 10d"352" and pos_row < 10d"356") and (pos_col >= 10d"524" and pos_col < 10d"616")) or
		((pos_row >= 10d"356" and pos_row < 10d"360") and (pos_col >= 10d"24" and pos_col < 10d"100")) or
		((pos_row >= 10d"356" and pos_row < 10d"360") and (pos_col >= 10d"372" and pos_col < 10d"452")) or
		((pos_row >= 10d"356" and pos_row < 10d"360") and (pos_col >= 10d"524" and pos_col < 10d"616")) or
		((pos_row >= 10d"360" and pos_row < 10d"364") and (pos_col >= 10d"24" and pos_col < 10d"100")) or
		((pos_row >= 10d"360" and pos_row < 10d"364") and (pos_col >= 10d"356" and pos_col < 10d"476")) or
		((pos_row >= 10d"360" and pos_row < 10d"364") and (pos_col >= 10d"532" and pos_col < 10d"616")) or
		((pos_row >= 10d"364" and pos_row < 10d"368") and (pos_col >= 10d"24" and pos_col < 10d"104")) or
		((pos_row >= 10d"364" and pos_row < 10d"368") and (pos_col >= 10d"344" and pos_col < 10d"476")) or
		((pos_row >= 10d"364" and pos_row < 10d"368") and (pos_col >= 10d"532" and pos_col < 10d"616")) or
		((pos_row >= 10d"368" and pos_row < 10d"372") and (pos_col >= 10d"24" and pos_col < 10d"104")) or
		((pos_row >= 10d"368" and pos_row < 10d"372") and (pos_col >= 10d"332" and pos_col < 10d"488")) or
		((pos_row >= 10d"368" and pos_row < 10d"372") and (pos_col >= 10d"532" and pos_col < 10d"616")) or
		((pos_row >= 10d"372" and pos_row < 10d"376") and (pos_col >= 10d"24" and pos_col < 10d"112")) or
		((pos_row >= 10d"372" and pos_row < 10d"376") and (pos_col >= 10d"320" and pos_col < 10d"488")) or
		((pos_row >= 10d"372" and pos_row < 10d"376") and (pos_col >= 10d"540" and pos_col < 10d"616")) or
		((pos_row >= 10d"376" and pos_row < 10d"380") and (pos_col >= 10d"24" and pos_col < 10d"112")) or
		((pos_row >= 10d"376" and pos_row < 10d"380") and (pos_col >= 10d"320" and pos_col < 10d"500")) or
		((pos_row >= 10d"376" and pos_row < 10d"380") and (pos_col >= 10d"540" and pos_col < 10d"616")) or
		((pos_row >= 10d"380" and pos_row < 10d"384") and (pos_col >= 10d"24" and pos_col < 10d"124")) or
		((pos_row >= 10d"380" and pos_row < 10d"384") and (pos_col >= 10d"296" and pos_col < 10d"500")) or
		((pos_row >= 10d"380" and pos_row < 10d"384") and (pos_col >= 10d"548" and pos_col < 10d"616")) or
		((pos_row >= 10d"384" and pos_row < 10d"388") and (pos_col >= 10d"24" and pos_col < 10d"136")) or
		((pos_row >= 10d"384" and pos_row < 10d"388") and (pos_col >= 10d"272" and pos_col < 10d"500")) or
		((pos_row >= 10d"384" and pos_row < 10d"388") and (pos_col >= 10d"536" and pos_col < 10d"616")) or
		((pos_row >= 10d"388" and pos_row < 10d"392") and (pos_col >= 10d"24" and pos_col < 10d"148")) or
		((pos_row >= 10d"388" and pos_row < 10d"392") and (pos_col >= 10d"244" and pos_col < 10d"504")) or
		((pos_row >= 10d"388" and pos_row < 10d"392") and (pos_col >= 10d"524" and pos_col < 10d"616")) or
		((pos_row >= 10d"392" and pos_row < 10d"396") and (pos_col >= 10d"28" and pos_col < 10d"160")) or
		((pos_row >= 10d"392" and pos_row < 10d"396") and (pos_col >= 10d"244" and pos_col < 10d"504")) or
		((pos_row >= 10d"392" and pos_row < 10d"396") and (pos_col >= 10d"512" and pos_col < 10d"616")) or
		((pos_row >= 10d"396" and pos_row < 10d"400") and (pos_col >= 10d"28" and pos_col < 10d"160")) or
		((pos_row >= 10d"396" and pos_row < 10d"400") and (pos_col >= 10d"232" and pos_col < 10d"616")) or
		((pos_row >= 10d"400" and pos_row < 10d"404") and (pos_col >= 10d"28" and pos_col < 10d"172")) or
		((pos_row >= 10d"400" and pos_row < 10d"404") and (pos_col >= 10d"208" and pos_col < 10d"616")) or
		((pos_row >= 10d"404" and pos_row < 10d"408") and (pos_col >= 10d"32" and pos_col < 10d"184")) or
		((pos_row >= 10d"404" and pos_row < 10d"408") and (pos_col >= 10d"196" and pos_col < 10d"616")) or
		((pos_row >= 10d"408" and pos_row < 10d"412") and (pos_col >= 10d"32" and pos_col < 10d"616")) or
		((pos_row >= 10d"412" and pos_row < 10d"416") and (pos_col >= 10d"32" and pos_col < 10d"616")) or
		((pos_row >= 10d"416" and pos_row < 10d"420") and (pos_col >= 10d"36" and pos_col < 10d"616")) or
		((pos_row >= 10d"420" and pos_row < 10d"424") and (pos_col >= 10d"36" and pos_col < 10d"616")) or
		((pos_row >= 10d"424" and pos_row < 10d"428") and (pos_col >= 10d"36" and pos_col < 10d"616")) or
		((pos_row >= 10d"428" and pos_row < 10d"432") and (pos_col >= 10d"36" and pos_col < 10d"412")) or
		((pos_row >= 10d"428" and pos_row < 10d"432") and (pos_col >= 10d"420" and pos_col < 10d"612")) or
		((pos_row >= 10d"432" and pos_row < 10d"436") and (pos_col >= 10d"44" and pos_col < 10d"400")) or
		((pos_row >= 10d"432" and pos_row < 10d"436") and (pos_col >= 10d"432" and pos_col < 10d"612")) or
		((pos_row >= 10d"436" and pos_row < 10d"440") and (pos_col >= 10d"44" and pos_col < 10d"388")) or
		((pos_row >= 10d"436" and pos_row < 10d"440") and (pos_col >= 10d"432" and pos_col < 10d"612")) or
		((pos_row >= 10d"440" and pos_row < 10d"444") and (pos_col >= 10d"56" and pos_col < 10d"376")) or
		((pos_row >= 10d"440" and pos_row < 10d"444") and (pos_col >= 10d"436" and pos_col < 10d"604")) or
		((pos_row >= 10d"444" and pos_row < 10d"448") and (pos_col >= 10d"56" and pos_col < 10d"364")) or
		((pos_row >= 10d"444" and pos_row < 10d"448") and (pos_col >= 10d"436" and pos_col < 10d"604")) or
		((pos_row >= 10d"448" and pos_row < 10d"452") and (pos_col >= 10d"68" and pos_col < 10d"336")) or
		((pos_row >= 10d"448" and pos_row < 10d"452") and (pos_col >= 10d"436" and pos_col < 10d"592")) or
		((pos_row >= 10d"452" and pos_row < 10d"456") and (pos_col >= 10d"80" and pos_col < 10d"312")) or
		((pos_row >= 10d"452" and pos_row < 10d"456") and (pos_col >= 10d"448" and pos_col < 10d"592")) or
		((pos_row >= 10d"456" and pos_row < 10d"460") and (pos_col >= 10d"92" and pos_col < 10d"300")) or
		((pos_row >= 10d"456" and pos_row < 10d"460") and (pos_col >= 10d"448" and pos_col < 10d"580")) or
		((pos_row >= 10d"460" and pos_row < 10d"464") and (pos_col >= 10d"104" and pos_col < 10d"288")) or
		((pos_row >= 10d"460" and pos_row < 10d"464") and (pos_col >= 10d"460" and pos_col < 10d"568")) or
		((pos_row >= 10d"464" and pos_row < 10d"468") and (pos_col >= 10d"104" and pos_col < 10d"288")) or
		((pos_row >= 10d"468" and pos_row < 10d"472") and (pos_col >= 10d"116" and pos_col < 10d"260")) or
		((pos_row >= 10d"472" and pos_row < 10d"476") and (pos_col >= 10d"128" and pos_col < 10d"248")) 
					else '1';
end;