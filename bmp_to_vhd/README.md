# bmp_to_vhd

The purpose of this little c++ script is to take an input image and convert it to constraints that can be copy-pasted into VHDL code for VGA display.  

THIS ONLY WORKS IF YOUR IMAGE IS TITLED `track.bmp`.    

It also may fail for certain types of bmp. I know for a fact it works if you use MS Paint, or if you export as a 24-bit bmp in GIMP with the "export colorspace information" setting unchecked.

To use it, you need to clone/download this Git repository, navigate to this directory, and compile the program using g++ or clang++.

The code is SUPER JANKY and COBBLED TOGETHER so be careful!

You have to manually set the (decimal) values of R, G, and B you're looking for (in the variable ref) as well as what 6-bit RGB binary code it corresponds to. Right now it only works on one color at a time, i.e. you have to generate the code for one color, then modify the cpp and recompile, then do the next, etc. It's awful!

FINAL NOTE, VERY IMPORTANT:

Because it's such a mess, some manual intervention is required after generating the constraints. The last line will have an extra "or" that you need to delete. Also make sure when you paste it in, all the syntax flows correctly. 
