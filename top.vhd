library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
  port(
    up_n    : in  std_logic; -- Buttons are active LOW
    down_n  : in  std_logic;
    left_n  : in  std_logic;
    right_n : in  std_logic;
    fire_n  : in  std_logic;
    
    vsync, hsync : out std_logic;
    rgb_o   : out std_logic_vector(5 downto 0);
    pll_o   : out std_logic;
		hsosc_o : out std_logic
  );
end top;

architecture synth of top is

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
    clk60   : in  std_logic;
    up_n    : in  std_logic; -- Buttons are active LOW
    down_n  : in  std_logic;
    left_n  : in  std_logic;
    right_n : in  std_logic;
    fire_n  : in  std_logic;
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
    vga_row, vga_col, pos_row, pos_col : in unsigned(9 downto 0);
    direction : in unsigned(2 downto 0);
    sprite_on : out std_logic;
    rgb_o : out std_logic_vector(5 downto 0)
  );
end component;

component renderer is
  port(
    track_rgb_i, sprite_rgb_i, score_rgb_i : in std_logic_vector(5 downto 0);
    sprite_on, score_on : in std_logic;
    rgb_o : out std_logic_vector(5 downto 0)
  );
end component;

component direction_calc is
  port(
		direction : out unsigned(2 downto 0)  := 3d"0";
    vel_x, vel_y  : in signed(3 downto 0) := 4d"0"
  );
end component;

signal clk48 : std_logic;
signal clk25 : std_logic;
signal valid : std_logic;
signal vga_row, vga_col, pos_row, pos_col : unsigned(9 downto 0);
signal vel_x, vel_y : signed(3 downto 0);
signal tk_rgb, sp_rgb, sc_rgb : std_logic_vector(5 downto 0);
signal sprite_on : std_logic;
signal direction : unsigned(2 downto 0);

begin
  hsosc_o <= clk48;

  hsosc_1      : hsosc      port map('1', '1', clk48);
  pll_1        : pll        port map(clk25, pll_o, clk48, '1');
  vga_1        : vga        port map(clk25, valid, vga_row, vga_col, hsync, vsync);
  pos_vel_1    : pos_vel    port map(vsync, up_n, down_n, left_n, right_n, fire_n, pos_row, pos_col, vel_x, vel_y);
  track_rgb_1  : track_rgb  port map(vga_row, vga_col, tk_rgb);
	sprite_rgb_1 : sprite_rgb port map(vga_row, vga_col, pos_row, pos_col, direction, sprite_on, sp_rgb);
  renderer_1   : renderer   port map(tk_rgb, sp_rgb, "000000", sprite_on, '0', rgb_o);
	direction_calc_1 : direction_calc port map(direction, vel_x, vel_y);
end;
