/*  
 *	VGA driver module; generates hsync and vsync signals. Uses two counters to
 *  control the timing. These counters generate the row and column that the VGA 
 *	scanning has currently reached. 
 *
 *	Input:
 *		clk - 25.125 MHz clock, according to VGA standard.
 *
 *	Outputs:
 *		valid   - Turns on when the row and col are less than (480,640).
 *		row/col - Values representing the row and column of the pixel associated with
 *							the current point in time in the VGA cycle. Up to (525,800). (0,0) 
 *							represents the top-left corner of the screen.
 *		hsync   - Usually HIGH, drops to LOW for a short period after every line of
 *							pixels as per the VGA standard.
 *		vsync   - Usually HIGH, drops to LOW for a short period after every frame as
 *							per the VGA standard.
 *
 */
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
  port(
    clk    : in  std_logic; -- 21.125 MHz
    
		valid  : out std_logic;
    
		row    : out unsigned (9 downto 0);
    col    : out unsigned (9 downto 0);
		
    hsync  : out std_logic;
    vsync  : out std_logic
  );
end vga;
    
architecture synth of vga is
begin
  hsync <= '0' when col > 10d"655" and col < 10d"752" else '1';
  vsync <= '0' when row > 10d"489" and row < 10d"492" else '1';
  valid <= '1' when col < 10d"640" and row < 10d"480" else '0';
  
  process (clk) begin
    if rising_edge(clk) then
      col <= col + 10d"1";
			
      if col = 10d"799" then
        col <= 10d"0";
        row <= row + 10d"1";
        if row = 10d"524" then
          row <= 10d"0";
        end if;
      end if;
			
    end if;  
  end process;
end;


