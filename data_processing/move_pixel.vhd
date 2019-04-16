/*  
 *  Top-level file to draw a moving pixel on the screen.  
 *  Later this will become sprite manipulation of some sort.
 *  
 *  Author(s):
 *    Alejandro
 *    Joe
 *   
 *  Version: 0.2.0
 *  Updated: 16 Apr 2019 by Joe
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity move_pixel is
  port(
    up_n    : in  std_logic; -- Buttons are active LOW
    down_n  : in  std_logic;
    left_n  : in  std_logic;
    right_n : in  std_logic;
    fire_n  : in  std_logic;
    clk_o   : out std_logic;
    hsync   : out std_logic;
    vsync   : out std_logic;
    rgb     : out unsigned(5 downto 0)
  );
end move_pixel;

architecture synth of move_pixel is

component hsosc is
  generic(
    clkhf_div : String := "0b00"
  );
  port(
    clkhfpu : in  std_logic := '1';
    clkhfen : in  std_logic := '1';
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

component clk_div is
  port(
	  clk60 : in  std_logic;
		clk10 : out std_logic := '0'
	);
end component;

component velocity is
  port(
	  clk           : in  std_logic; 
    u, d, l, r, f : in std_logic; 
    vel_x, vel_y  : out signed(3 downto 0) := 4d"0"
    );
end component;

component position is
  port(
    clk          : in  std_logic; 
		vel_x, vel_y : in signed(3 downto 0);
    row          : out unsigned(9 downto 0) := 10d"240";
    col          : out unsigned(9 downto 0) := 10d"320"
  );
end component;

signal clk48 : std_logic; -- 48 MHz
signal clk25 : std_logic; -- 25.125 MHz
signal clk10 : std_logic; -- 10 Hz
signal valid : std_logic; 

signal vga_row : unsigned(9 downto 0);
signal vga_col : unsigned(9 downto 0);
signal pos_row : unsigned(9 downto 0); 
signal pos_col : unsigned(9 downto 0);
signal vel_x   : signed(3 downto 0);
signal vel_y   : signed(3 downto 0);

begin
  hsosc_1    : hsosc    port map('1', '1', clk48);
  pll_1      : pll      port map(clk25, clk_o, clk48, '1');
  vga_1      : vga      port map(clk25, valid, vga_row, vga_col, hsync, vsync);
	clk_div_1  : clk_div  port map(vsync, clk10); -- Divide the 60 Hz vsync pulse down to 10 Hz 
	velocity_1 : velocity port map(clk10, not up_n, not down_n, not left_n, not right_n, not fire_n, vel_x, vel_y);
	position_1 : position port map(vsync, vel_x, vel_y, pos_row, pos_col);

	rgb <= "000000" when not valid else
         "111111" when pos_row = vga_row and pos_col = vga_col else 
         "000000"; 
end;






