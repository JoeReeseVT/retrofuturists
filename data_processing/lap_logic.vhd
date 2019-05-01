/*
 *	Keeps track of a player's score based on how many times they've gone around the
 *  track. This is accomplished by creating two regions of the screen (defined by row
 *	and column bounds) that trigger a state change. There are two possible states, one
 *  where the left region is active, and one where the right region is active. If the
 *	player enters the active region in the current state, we move to the other state,
 *  deactivating the current region and activating the one on the opposite side. 
 *
 *  The score is only incremented by the left region, thus requiring the player to
 *  reach the right region (on the other side of the track) before they can increment
 *  their score. 
 *
 *  In short, the player must reach a halfway checkpoint for crossing the finish line
 *  to actually count.
 *
 *  Inputs:
 *		reset - Active LOW signal used to initialize the score and active state.
 *		clk   - Sort of arbitrary frequency, as long as it's fast enough that a player
 *						couldn't skip past the active region in the time needed to detect them.
 *
 *		pos_row/col - Player's current position on the screen. (479,639) is bottom-right.
 *
 *	Output:
 *		score - Number of laps the player has completed. Possible values 0 to 5.
 *
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lap_logic is
  port(
	  reset   : in  std_logic;
		clk			: in  std_logic;
		
		pos_col : in  unsigned(9 downto 0);
		pos_row : in  unsigned(9 downto 0);
		
    score 	: out unsigned(2 downto 0) := 3d"0"
  );
end lap_logic;

architecture synth of lap_logic is

/* Define possible states */
type state is (half, last);  
signal s : state := half;

begin 
process(clk, reset) begin
  if not reset then
    score <= 3d"0"; 

	elsif rising_edge(clk) then 	
	
  	/* Right region is active */
		if s = half then 
			score <= score;
			if pos_row > 10d"220" and pos_row < 10d"260" and 
			   pos_col > 10d"480" and pos_col < 10d"600" then
				s <= half;
			else
				s <= half;
			end if;
		end if;
		
		/* Left region is active */
		if s = last then
			score <= score;
			if pos_row > 10d"220" and pos_row < 10d"260" and 
			   pos_col > 10d"20"  and pos_col < 10d"120" then
				if score = 3d"5" then
					score <= 3d"0";
				else
					score <= score + 3d"1";
				end if;
				s <= half;
			else 
				s <= last;
			end if;
		end if;
		
	end if;	
end process;
end;
