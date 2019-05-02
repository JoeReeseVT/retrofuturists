# Retroracer 2600

An FPGA-based racing game inspired by the Atari 2600 game "Indy 500". 

### Authors:  
Alejandro Colina-Valeri  
Brandon Gray  
Paige Shephard  
Joseph Reese  
___

### Basic premise  
This project is written in VHDL for the Lattice iCE40UP5K FPGA. There are two players. Each uses an Atari-like joystick (4 directions and a "fire" button) to  control the movement of a small colored square. The goal is to navigate this "car" around a track to complete 5 laps before your opponent.

Currently, there is no win-state for the game, and there are several visual oddities resulting from our method of graphics rendering.

![top-level block diagram](/block_diagram.pdf)  
![block diagram for position/velocity module](/block_diagram_pos_vel.pdf)
