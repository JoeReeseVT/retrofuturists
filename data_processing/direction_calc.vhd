library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity direction_calc is
  port(
		direction : out unsigned(1 downto 0)  := 2d"0"; -- direciton is 2 bit, NOT 3 bit!!
    vel_x, vel_y  : in signed(3 downto 0) := 4d"0"
  );
end direction_calc;

architecture synth of direction_calc is
begin

direction <= 2d"0" when vel_y < 4d"0" and abs(vel_y) >= abs(vel_x) else
						 2d"1" when vel_x < 4d"0" and abs(vel_x) > abs(vel_y)  else
						 2d"2" when vel_y > 4d"0" and abs(vel_y) >= abs(vel_x) else
						 2d"3" when vel_x > 4d"0" and abs(vel_x) > abs(vel_y);
end;
