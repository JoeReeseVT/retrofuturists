# bmp_to_vhd

The purpose of this little c++ script is to take an input image and convert it to constraints that can be copy-pasted into VHDL code for VGA display.  

It also may fail for certain types of bmp. I know for a fact it works if you use MS Paint, or if you export as a 24-bit bmp in GIMP with the "export colorspace information" setting unchecked.

To use it, you need to clone/download this Git repository, navigate to this directory, and compile the program using the c++ compiler of your choice.

The code is SUPER JANKY and COBBLED TOGETHER so be careful!
 
By default, the script DOWNSAMPLES by a factor of 5. You can alter this by changing the for loop incrementing interval. 

Also by default, the script looks for RED, i.e. RGB 255 0 0, or hex FF0000. This will not affect what color your final graphic is, obviously. 

FINAL NOTE, VERY IMPORTANT:

Because it's such a mess, some manual intervention is required after generating the constraints. The last line will have an extra "or" that you need to delete. Also make sure when you paste it in, all the syntax flows correctly. 
