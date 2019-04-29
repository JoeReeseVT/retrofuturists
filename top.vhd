library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
  port(
    up_1    : in  std_logic; -- Buttons are active LOW
    down_1  : in  std_logic; -- car #1
    left_1  : in  std_logic;
    right_1 : in  std_logic;
    fire_1  : in  std_logic;
		
		up_2    : in  std_logic; -- Buttons are active LOW
    down_2  : in  std_logic; -- car#2
    left_2  : in  std_logic;
    right_2 : in  std_logic;
    fire_2  : in  std_logic;
	
	  reset : in std_logic;
   
    vsync, hsync : out std_logic;
    rgb_o   : out std_logic_vector(5 downto 0);
    pll_o   : out std_logic;
		hsosc_o : out std_logic
  );
end top;

architecture synth of top is

component lsosc is
  port(
    clklfpu : in  std_logic := 'X';
    clklfen : in  std_logic := 'X';
    clklf   : out std_logic := 'X'
  );
end component;

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
    outglobal_o: out std_logic;
    outcore_o: out std_logic;
    ref_clk_i: in std_logic;
    rst_n_i: in std_logic
  );
end component;

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

component pos_vel is
  port(
	  player  : in std_logic;
	  clk_10k : in  std_logic;
    clk60   : in  std_logic;
    up_n    : in  std_logic; -- Buttons are active LOW
    down_n  : in  std_logic;
    left_n  : in  std_logic;
    right_n : in  std_logic;
    fire_n  : in  std_logic;
	  reset : in std_logic;
    pos_row : out unsigned(9 downto 0); 
    pos_col : out unsigned(9 downto 0);
    vel_x   : out signed(3 downto 0);
    vel_y   : out signed(3 downto 0)
  );
end component;

component track_rgb is
  port(
    vga_row, vga_col : in unsigned(9 downto 0);
    rgb_o : out std_logic_vector(5 downto 0)
  );
end component;

component sprite_rgb is
  port(
		color : in std_logic_vector(5 downto 0);
    vga_row, vga_col, pos_row, pos_col : in unsigned(9 downto 0);
    sprite_on : out std_logic;
    rgb_o : out std_logic_vector(5 downto 0)
  );
end component;

component score_rgb is 
	port(
		color : in std_logic_vector(5 downto 0);
		score : in unsigned(2 downto 0);
		vga_row, vga_col : in unsigned(9 downto 0);
		score_on : out std_logic;
		rgb_o : out std_logic_vector(5 downto 0)
	);
end component;

component renderer is
  port(
    track_rgb_i, sprite_rgb_i, score_rgb_i, sprite_rgb_i2, score_rgb_i2 : in std_logic_vector(5 downto 0);
    sprite_on, score_on, sprite_on2, score_on2 : in std_logic;
    rgb_o : out std_logic_vector(5 downto 0)
  );
end component;

component direction_calc is
  port(
		direction : out unsigned(2 downto 0)  := 3d"0";
    vel_x, vel_y  : in signed(3 downto 0) := 4d"0"
  );
end component;

component lap_logic is
  port(
		clk			: in std_logic;
		pos_col : in unsigned(9 downto 0);
		pos_row : in unsigned(9 downto 0);
    score 	: out  unsigned(2 downto 0) := 3d"5"
  );
end component;
  
signal clk48  : std_logic;
signal clk_10k : std_logic;
signal clk25  : std_logic;
signal valid  : std_logic;

signal vga_row, vga_col, pos_row, pos_col, pos_row2, pos_col2 : unsigned(9 downto 0);

signal vel_x, vel_y : signed(3 downto 0);
signal vel_x2, vel_y2 : signed(3 downto 0);
signal tk_rgb, sp_rgb, sp_rgb2, sc_rgb, sc_rgb2 : std_logic_vector(5 downto 0);
signal sprite_on, sprite_on2 : std_logic;
signal score_on, score_on2 : std_logic;
signal score, score2 : unsigned(2 downto 0);

begin
  hsosc_o <= clk48;
  hsosc_1      : hsosc       port map('1', '1', clk48);
	lsosc_1      : lsosc       port map('1', '1', clk_10k);
  pll_1        : pll         port map(clk25, pll_o, clk48, '1');
  vga_1        : vga         port map(clk25, valid, vga_row, vga_col, hsync, vsync);
  pos_vel_1    : pos_vel     port map('0', clk_10k, vsync, up_1, down_1, left_1, right_1, fire_1, reset, pos_row, pos_col, vel_x, vel_y);
	pos_vel_2 	 : pos_vel	   port map('1', clk_10k, vsync, up_2, down_2, left_2, right_2, fire_2, reset, pos_row2, pos_col2, vel_x2, vel_y2);

  track_rgb_1  : track_rgb   port map(vga_row, vga_col, tk_rgb);
	sprite_rgb_1 : sprite_rgb  port map("110000", vga_row, vga_col, pos_row, pos_col, sprite_on, sp_rgb);
	sprite_rgb_2 : sprite_rgb  port map("000011", vga_row, vga_col, pos_row2, pos_col2, sprite_on2, sp_rgb2);
	score_rgb_1  : score_rgb   port map("110000", score, vga_row, vga_col, score_on, sc_rgb);
	score_rgb_2  : score_rgb   port map("000011", score2, vga_row, vga_col, score_on2, sc_rgb2);
	renderer_1   : renderer    port map(tk_rgb, sp_rgb, sc_rgb, sp_rgb2, sc_rgb2, sprite_on, score_on, sprite_on2, score_on2, rgb_o);
	lap_logic_1  : lap_logic   port map(vsync, pos_col, pos_row, score);
	lap_logic_2	 : lap_logic   port map(vsync, pos_col2, pos_row2, score2);
end; 
