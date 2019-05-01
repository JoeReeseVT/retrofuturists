# bmp_to_vhd

```
Usage: bmp_to_vhd [-d|--downscale INT] FILENAME
-d will downsample the image dimensions to 1/INT.
```

The purpose of this little c++ script is to take an input image and convert it to constraints that can be copy-pasted into VHDL code for VGA display.  

It may fail for certain types of bmp. I know for a fact it works if you use MS Paint, or if you export as a 24-bit bmp in GIMP with the "export colorspace information" setting unchecked.

To use it, you need to clone/download this Git repository, navigate to this directory, and compile the program via command line. 

If you want to compile on Windows, download the free version of Visual Studio. In the Visual Studio installer program, select "Desktop Development with C++". You don't need any of the other tools for this. After the module downloads and installs itself, search the Start Menu for "Developer Command Prompt". If it comes up, type `cl` to make sure the command is recognized. You should get a "usage" message. Navigate to the bmp_to_vhd directory and type:

```
cl /EHsc /std:c++17 bmp_to_vhd.cpp
``` 

The program should compile. Now to run it, simply type `bmp_to_vhd` and you should again see a usage message appear.

The code is SUPER JANKY and COBBLED TOGETHER so be careful!

The program looks for RED (RGB 255 0 0 or hex FF0000) to define its constraints. Obviously you can use the constraints generated to make any color you want in VHDL. The choice of RED is basically arbitrary.

FINAL NOTE, VERY IMPORTANT:

Because it's such a mess, some manual intervention is required after generating the constraints. The last line will have an extra "or" that you need to delete. Also make sure when you paste it in, all the syntax flows correctly. 
