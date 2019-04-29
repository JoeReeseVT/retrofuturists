/*  
 *  Module to calculate player position and velocity from inputs
 *  
 *  Author(s):
 *    Alejandro
 *    Joe
 *   
 *  Version: 0.2.1
 *  Updated: 26 Apr 2019 by Joe
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pos_vel is
  port(
	  player    : in  std_logic;
	  clk_10k   : in  std_logic;
    clk60     : in  std_logic;
    up_n      : in  std_logic; -- Buttons are active LOW
    down_n    : in  std_logic;
    left_n    : in  std_logic;
    right_n   : in  std_logic;
    fire_n    : in  std_logic;
		reset     : in  std_logic;
    pos_row   : out unsigned(9 downto 0); 
    pos_col   : out unsigned(9 downto 0);
    vel_x     : out signed(3 downto 0);
    vel_y     : out signed(3 downto 0)
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
	  clk           : in  std_logic; 
    u, d, l, r, f : in std_logic;
		off_track     : in  std_logic; -- rgb_o(4) from the track rgb output		
    vel_x, vel_y  : out signed(3 downto 0) := 4d"0"
    );
end component;

component pos_clk is
	port(
		clk10k  : in std_logic;
		velocity : in signed(3 downto 0);
		clk_o : out std_logic
  );
end component;

component position is
  port(
		reset : in std_logic;
	  player       : in  std_logic;
	  clk_main     : in  std_logic; -- fixed speed (really just for initializing)
    clk_x, clk_y : in  std_logic; -- variable speed
		neg_x, neg_y : in  std_logic;
    row : out unsigned(9 downto 0) := 10d"240";
    col : out unsigned(9 downto 0) := 10d"320"
  );
end component;

signal clk30 : std_logic; -- 10 Hz
signal off_track : std_logic;
signal clk_x, clk_y : std_logic;

begin
	find_track_1 : find_track port map(pos_row, pos_col, off_track);
	clk_div_1    : clk_div    port map(clk60, clk30); -- Divide the 60 Hz vsync pulse down to 10 Hz 
  velocity_1   : velocity   port map(clk30, not up_n, not down_n, not left_n, not right_n, not fire_n, off_track, vel_x, vel_y);
	pos_clk_x    : pos_clk    port map(clk_10k, vel_x, clk_x);
	pos_clk_y    : pos_clk    port map(clk_10k, vel_y, clk_y);
	position_1   : position   port map(reset, player, clk60, clk_x, clk_y, vel_x(3), vel_y(3), pos_row, pos_col);
end;






