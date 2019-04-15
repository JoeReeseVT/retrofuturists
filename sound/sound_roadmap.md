# Sound
- tone generator (chromatic)
- takes note # (0-11), octave # (0-3), , note enable, and clock, outputs a squarewave with frequency on the input value
- can use a low pass filter on one of these to approximate a triangle wave for bass notes 
- total of 12 notes per octave; 12 different counter values to count to, higher octave means divide the count by 2
- to get a frequency, a counter counts up to a reference value. when that value is hit, invert the square wave. (this means the freq is actually half what we'd expect. I.e., we only need to count half the value we'd expect) 

### Note frequencies 

Counter value calculated by `48 MHz / (2 * note Freq)` rounded to nearest int:

```
C2 = 65.41: count to 366916  (19 bit reference value) 
C#2 = 69.30: count to 346320
D2 =  73.42: 326886
D#2 = 77.78: 308563
E2 = 82.41: 291227
F2 = 87.31: 274883
F#2 = 92.50: 259459
G2 = 98.00: 244898
G#2 = 103.83: 231147
A2 = 110: 218182
A#2 = 116.54: 205938
B2 = 123.47: 194379
```

example :

```
process (clk) begin
  if rising_edge(clk) then
    if count = (rev_val / octave) then
      count <= 0;
      wave <= not wave;
    else
      count <= count + 1;
  end if;
end process;
```
