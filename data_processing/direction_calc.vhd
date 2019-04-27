library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity direction_calc is
  port(
		direction : out unsigned(2 downto 0)  := 3d"0";
    vel_x, vel_y  : in signed(3 downto 0) := 4d"0"
  );
end direction_calc;

architecture synth of direction_calc is
begin

direction <= 3d"0" when vel_y < 4d"0" and vel_x = 4d"0" else
						 3d"2" when vel_y = 4d"0" and vel_x < 4d"0" else
						 3d"4" when vel_y >= 4d"0" and vel_x = 4d"0" else
						 3d"6" when vel_y = 4d"0" and vel_x >= 4d"0" else
						 3d"1" when vel_y < 4d"0" and vel_x < 4d"0" else
						 3d"3" when vel_y >=4d"0" and vel_x < 4d"0" else
						 3d"5" when vel_y >= 4d"0" and vel_x >= 4d"0" else
						 3d"7";
end;
