/*
 *	Retroracer 2600 top module. Interfaces the various modules to the FPGA I/O pins. 
 *  See module files for their individual descriptions.
 *
 *	Inputs:
 *  	up/down/lef/right/fire_1/2 - Joystick inputs for each player (active LOW).
 *		
 *		reset - Active LOW reset button to re-initialize score and position.
 *
 *  Outputs:
 *		vsync/hsync - Standard VGA protocol signals.
 *    rgb_o       - VGA RGB output, format RRGGBB, converted to analog externally.
 *
 *    pll/hsosc_o - Clock outputs to ensure correct frequencies.
 *
 */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
  port(
    up_1    : in  std_logic; -- Buttons are active LOW
    down_1  : in  std_logic; -- Car #1
    left_1  : in  std_logic;
    right_1 : in  std_logic;
    fire_1  : in  std_logic;
		
		up_2    : in  std_logic; -- Buttons are active LOW
    down_2  : in  std_logic; -- Car #2
    left_2  : in  std_logic;
    right_2 : in  std_logic;
    fire_2  : in  std_logic;
		
	  reset   : in  std_logic; -- Active LOW
    
    vsync   : out std_logic;
		hsync   : out std_logic;		
    rgb_o   : out std_logic_vector(5 downto 0);
		
		sound_o : out std_logic;
		
		/* Debugging outputs */
    pll_o   : out std_logic;
		hsosc_o : out std_logic 
  );
end top;

architecture synth of top is

/* Low speed oscillator to drive pos_clk module */
component lsosc is
  port(
    clklfpu : in  std_logic := 'X';
    clklfen : in  std_logic := 'X';
    clklf   : out std_logic := 'X'
  );
end component;

/* High speed oscillator, drives the PLL */
component hsosc is
  generic(
    clkhf_div : String := "0b00"
  );
  port(
    clkhfpu : in  std_logic := 'X';
    clkhfen : in  std_logic := 'X';
    clkhf   : out std_logic := 'X'
  );
end component;

component pll is
  port(
    outglobal_o : out std_logic; -- Internal output
    outcore_o   : out std_logic; -- Pin output
		
    ref_clk_i   : in std_logic;
    rst_n_i     : in std_logic   -- Reset, active LOW
  );
end component;

/* Generate the signals necessary for standard VGA protocol */
component vga is
  port(
    clk    : in  std_logic; -- 21.125 MHz
    
		valid  : out std_logic;
    
		row    : out unsigned (9 downto 0);
    col    : out unsigned (9 downto 0);
		
    hsync  : out std_logic;
    vsync  : out std_logic
  );
end component;

/* Calculate player's position and velocity */
component pos_vel is
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
end component;

/* Generate the VGA's RGB pattern for the background */
component track_rgb is
  port(
    vga_row : in  unsigned(9 downto 0);
		vga_col : in  unsigned(9 downto 0);
		
    rgb_o   : out std_logic_vector(5 downto 0)
  );
end component;

/* Generate the RGB pattern for the player's "car" */
component sprite_rgb is
  port(
		color     : in  std_logic_vector(5 downto 0);
    
		vga_row   : in  unsigned(9 downto 0);
		vga_col   : in  unsigned(9 downto 0);
		pos_row   : in  unsigned(9 downto 0);
		pos_col   : in  unsigned(9 downto 0);
    
		sprite_on : out std_logic;
    rgb_o     : out std_logic_vector(5 downto 0)
  );
end component;

/* Generate the RGB pattern for the digits 0-5 at the top of the screen */
component score_rgb is 
	port(
		player   : in  std_logic;
		color    : in  std_logic_vector(5 downto 0);
		score    : in  unsigned(2 downto 0);
    
		vga_row  : in  unsigned(9 downto 0);
		vga_col  : in  unsigned(9 downto 0);
		
		score_on : out std_logic;
		rgb_o    : out std_logic_vector(5 downto 0)
	);
end component;

/* Decide which of the incoming RGB signals to output for the current pixel */
component renderer is
  port(
    track_rgb_i   : in std_logic_vector(5 downto 0);
		
		sprite_rgb_i  : in std_logic_vector(5 downto 0);
    score_rgb_i   : in std_logic_vector(5 downto 0);
		
		sprite_rgb_i2 : in std_logic_vector(5 downto 0);
		score_rgb_i2  : in std_logic_vector(5 downto 0);
		
    sprite_on     : in std_logic;
		score_on      : in std_logic;
		
		sprite_on2    : in std_logic;
		score_on2     : in std_logic;
		
    rgb_o         : out std_logic_vector(5 downto 0)	
  );
end component;

/* Keep track of score as the player circles the track */
component lap_logic is
  port(
	  reset   : in  std_logic;
		clk			: in  std_logic;
		
		pos_col : in  unsigned(9 downto 0);
		pos_row : in  unsigned(9 downto 0);
		
    score 	: out unsigned(2 downto 0) := 3d"0"
  );
end component;

component song is
	port (
	  clk25 : in std_logic;
		wave : out std_logic
	);
end component;

/* Clocks */
signal clk_10k : std_logic; -- 10 kHz clock from LSOSC
signal clk48   : std_logic;  -- 48 MHz clock from HSOSC
signal clk25   : std_logic;  -- 25.125 MHz clock from PLL

/* VGA driver outs */
signal valid   : std_logic;
signal vga_row : unsigned(9 downto 0);
signal vga_col : unsigned(9 downto 0);

/* Player position data */
signal pos_row  : unsigned(9 downto 0); 
signal pos_col  : unsigned(9 downto 0);

signal pos_row2 : unsigned(9 downto 0);
signal pos_col2 : unsigned(9 downto 0);

/* Player velocity data (UNUSED) */
signal vel_x  : signed(3 downto 0);signal vel_y  : signed(3 downto 0);

signal vel_x2 : signed(3 downto 0);
signal vel_y2 : signed(3 downto 0);

/* RGB output signals */
signal tk_rgb  : std_logic_vector(5 downto 0); -- track_rgb

signal sp_rgb  : std_logic_vector(5 downto 0); -- sprite_rgb
signal sp_rgb2 : std_logic_vector(5 downto 0);

signal sc_rgb  : std_logic_vector(5 downto 0); -- score_rgb
signal sc_rgb2 : std_logic_vector(5 downto 0);

/* Flags sent to renderer */
signal sprite_on  : std_logic;signal sprite_on2 : std_logic;

signal score_on   : std_logic;signal score_on2  : std_logic;

/* Score values */
signal score  : unsigned(2 downto 0);
signal score2 : unsigned(2 downto 0);

begin
  hsosc_o <= clk48;
	
	/* Component instantiations */
  lsosc_1      : lsosc       port map('1', '1', clk_10k);
  hsosc_1      : hsosc       port map('1', '1', clk48);
  pll_1        : pll         port map(clk25, pll_o, clk48, '1');
	
  vga_1        : vga         port map(clk25, valid, vga_row, vga_col, hsync, vsync);
	
  pos_vel_1    : pos_vel     port map('0', clk_10k, vsync, up_1, down_1, left_1, right_1, fire_1, reset, pos_row, pos_col, vel_x, vel_y);
	pos_vel_2 	 : pos_vel	   port map('1', clk_10k, vsync, up_2, down_2, left_2, right_2, fire_2, reset, pos_row2, pos_col2, vel_x2, vel_y2);
  
	track_rgb_1  : track_rgb   port map(vga_row, vga_col, tk_rgb);
	
	sprite_rgb_1 : sprite_rgb  port map("110000", vga_row, vga_col, pos_row, pos_col, sprite_on, sp_rgb);
	sprite_rgb_2 : sprite_rgb  port map("000011", vga_row, vga_col, pos_row2, pos_col2, sprite_on2, sp_rgb2);
	
	score_rgb_1  : score_rgb   port map('0', "110000", score, vga_row, vga_col, score_on, sc_rgb);
	score_rgb_2  : score_rgb   port map('1', "000011", score2, vga_row, vga_col, score_on2, sc_rgb2);
	
	renderer_1   : renderer    port map(tk_rgb, sp_rgb, sc_rgb, sp_rgb2, sc_rgb2, sprite_on, score_on, sprite_on2, score_on2, rgb_o);
	
	lap_logic_1  : lap_logic   port map(reset, vsync, pos_col, pos_row, score);
	lap_logic_2	 : lap_logic   port map(reset, vsync, pos_col2, pos_row2, score2);
	
	song_1       : song        port map(clk25, sound_o);
end; 
