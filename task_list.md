### Project name
~~We need a cool working title :)~~ *RETRORACER 2600!*

___

### Graphics
- this is the most important part to get done FIRST so we can test stuff as we build it.  
- first just make something to display a blank screen except for a single pixel specified by row/col. This will let us test the first step of data processing: making row & col move. We can repurpose lab 5 code.
- next step will be to draw this coordinate as a big square, to demonstrate being able to move a graphic around.   
- we need to brainstorm a good way to store the data needed to draw a background. We can start in monochrome to make it easier  
- handling colors will come later but it's good to start thinking about how they'll work.
- We won't want to select from a whole 64 colors when we'll probably only need like 8 anyway. We can make a "color decoder" module (outline added to graphics/graphics_roadmap) to take 3-bits and return the RGB code needed to drive the VGA dongle. Ex, `000` could return `000000` (black), `001` could return `110000` (fully red), `110` could return `101111` (light cyan), `111` could return `111111` (white). 
- We'll need to decide on a color palette before we can actually code this^, so someone needs to design the background art. Keep in mind: the lap numbers/any text we show can share colors with the car of the player they represent, so like blue car, blue text. But that still means up to 4 colors will be used for cars+text, so background colors may be limited to 4 colors too.

___

### I/O
- ~~I (joe) have some pushbuttons I can solder up on perfboard to model the joystick.~~ Done
- based on the atari controller pinout, we could assign the pins like this:
  - this isn't the only way to do this so if anyone has a better idea speak up
```
pin 1 = up    = bit 0
pin 2 = down  = bit 1
pin 3 = left  = bit 2
pin 4 = right = bit 3
pin 6 = fire  = bit 4
```
ex.
```
00000 = no inputs
00001 = up 
10001 = up and fire
00110 = down-left 
11010 = fire, down-right
```
note : `X11XX` and `XXX11` are invalid; you can't push left-right or up-down at the same time.
also : we don't necessarily have to store all the inputs in a single 5-bit number, since VHDL  
doesn't really care what you name something. 

___

### Data processing
- must keep track of col and row in a 640 x 480 region. 
- to start with, probably figure out how to move the row / col in a direction based on inputs. You can model the inputs with dip switches or even just wires connecting FPGA pins to 3.3 V or GND
- next step will be to have the dot accelerate/decelerate to certain velocities rather than hard start/stop.  We'll also need to be able to change that max velocity as a value depending on if the position is within a certain range. This is a complex task we will probably need to divide further.
- Maybe store horiz and vertical speeds as two 8-bit (maybe 4-bit?) signed values, where positive is up/left and negative is down/right. 
- This should make it easier to write logic so we know what direction the car is facing.

___

### Sound
- I have the start of a musical note generator written in sound/sound_roadmap. I or someone else can start with just generating one frequency with controllable octave (see ), then expanding the code so we have all 12 tones.
- We also need to be able to drive the engine sounds, which won't be able to use the chromatic scale. How do we get continuously variable pitch? 
  - Specifically, how can we make pitch a function of velocity? 
  - Perhaps add/subtract a certain number of clock cycles per point of velocity?
- Because frequency is perceived logarithmically, adding X Hz to a low frequency sounds like a bigger difference than adding X Hz to a high frequency. This is good because it means the perceived pitch will increase fast at first then more slowly as you go higher, much like real engine sounds as RPM increases
- something like:
```
ref_val <= start_val - (100 * speed); 

...

if count = ref_val then
  count <= 19d"0";
  wave  <= not wave;
else
  count <= count + 1;
end if;
```
- if horiz/vert speeds are signed, must convert to unsigned here. If the MSB is 1, take the inverse and add 1 to convert to absolute value)
