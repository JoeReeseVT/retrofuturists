# ES4 final project design general notes

### General ideas:
- 2 atari 2600-style joysticks
  - consist of 5 momentary switches: 4 for direction, 1 for "other"
  - pinout for female connector pictured:
![pinout](/atari_pinout_female.png)
- some kind of racing game
- static background to simplify graphics logic
- must keep track of what is track and what isn't--grass should slow you down
  - probably make a few different tracks to choose from?
- players race X laps around a track
  - must handle position, velocity, acceleration?
    - when no input, decelerate until zero 
    - direction input accelerates the player in that direction up to a maximum velocity
- probably 8 graphics sprites to switch between depending on what direction the player is going in, i.e. in what direction is the biggest component of their velocity 
- collision between cars? if so, probably just model it as a rectangle 
- being on grass reduces max velocity--if you enter grass above that velocity you get decelerated
    - VGA output: 640x480 px. 
- will have to implement architectures to store sprite and background graphics, as well as to interface them to the vga driver
- the VGA models used in lab have 2 bits output for each R, G, and B. a DAC converts them to analog voltages giving effectively 64 different colors. 
- we don't need 64 colors--can set palette(s) of 8 colors and multiplex, so we only need 3 color bits output? may not be necessary
    - basic squarewave sounds for engines, "3 2 1 go" beeps, other little sounds to add charm 
- input value determines how many clock cycles a pulse lasts, so as you lower the value the pitch rises?
- maybe a noise generator using an LFSR?
- if we have time maybe some fun chiptune menu music

