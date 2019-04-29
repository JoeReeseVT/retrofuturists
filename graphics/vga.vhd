/*  
 *  VGA driver module; generates HSYNC and VSYNC signals
 *  
 *  Author(s) :
 *    Joe
 *    Alejandro
 *
 *  Version: 0.1.0
 *  Updated: 15 Apr 2019 by Joe
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


