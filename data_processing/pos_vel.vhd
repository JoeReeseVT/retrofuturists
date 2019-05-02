/*  
 *  Module to calculate player position and velocity from inputs. See module files for their 
 *  individual descriptions.
 * 
 *  Inputs: 
 *  	up/down/lef/right/fire - Joystick inputs for each player (active LOW).
 *
 *    reset - Active LOW reset button to re-initialize player position.
 *
 *  Outputs:
 *		pos_row/col - Player's current position on the screen. (479,639) is bottom-right.
 *		vel_x/y   	- Player's current velocity in each axis. 4-bit signed.
 *
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pos_vel is
  port(
	  player  : in  std_logic;
		
	  clk_10k : in  std_logic;
    clk60   : in  std_logic;
    
		up_n    : in  std_logic; -- Buttons are active LOW
    down_n  : in  std_logic;
    left_n  : in  std_logic;
    right_n : in  std_logic;
    fire_n  : in  std_logic;
		
		reset   : in  std_logic; -- Active LOW
    
		pos_row : out unsigned(9 downto 0); 
    pos_col : out unsigned(9 downto 0);
    
		vel_x   : out signed(3 downto 0);
    vel_y   : out signed(3 downto 0)
  );
end pos_vel;

architecture synth of pos_vel is

component clk_div is
  port(
	  clk60 : in  std_logic;
		clk30 : out std_logic := '0'
	);
end component;

component find_track is
  port(
	  pos_row, pos_col : in  unsigned(9 downto 0);
		off_track        : out std_logic
  );
end component;

component velocity is
  port(
	  clk     : in  std_logic; -- 30 Hz
   
 	  u       : in  std_logic; -- Up button
		d       : in  std_logic; -- Down button
		l       : in  std_logic; -- Left button
		r       : in  std_logic; -- Right button
		f       : in  std_logic; -- Fire button
		
		off_trk : in  std_logic; -- rgb_o(4) from the track rgb output
    
		vel_x   : out signed(3 downto 0) := 4d"0";
		vel_y   : out signed(3 downto 0) := 4d"0"
  );
end component;

component pos_clk is
	port(
		clk_10k  : in  std_logic;
		velocity : in  signed(3 downto 0);
		
		clk_o 	 : out std_logic
  );
end component;

component position is
  port(
	  reset    : in  std_logic;
		player   : in  std_logic;
		
    clk_x    : in  std_logic;
		clk_y    : in  std_logic;
		
		neg_x    : in  std_logic; 
		neg_y    : in  std_logic;
		
    row      : out unsigned(9 downto 0);
    col      : out unsigned(9 downto 0)
  );
end component;

signal clk30   : std_logic; -- 30 Hz for updating velocity.

signal off_trk : std_logic; -- Flag if the player is outside the track boundaries.

signal clk_x   : std_logic; -- Variable clocks governing position update rate.
signal clk_y   : std_logic;

begin
	clk_div_1    : clk_div    port map(clk60, clk30); -- Divide the 60 Hz vsync pulse down to 30 Hz 
	
	find_track_1 : find_track port map(pos_row, pos_col, off_trk);
  
	velocity_1   : velocity   port map(clk30, not up_n, not down_n, not left_n, not right_n, not fire_n, off_trk, vel_x, vel_y);

  pos_clk_x    : pos_clk    port map(clk_10k, vel_x, clk_x);
	pos_clk_y    : pos_clk    port map(clk_10k, vel_y, clk_y);
	
	position_1   : position   port map(reset, player, clk_x, clk_y, vel_x(3), vel_y(3), pos_row, pos_col);
end;






