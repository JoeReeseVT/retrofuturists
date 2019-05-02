#include <fstream>
#include <iostream>
#include "bitmap_image.hpp"

using namespace std;

void usage_err() {
  cerr << "\tUsage: bmp_to_vhd [-d|--downscale] INT FILENAME\n"
       << "\t-d will downsample the image dimensions to 1/INT.\n";
  exit(1);
}

int main(int argc, char *argv[]) {
  
  string in_path;
  int shrink_fac; // Downsamples image dimensions to 1/shrink_fac

  /* Parse command line arguments */
  if (argc == 4) 
    if (string(argv[1]) == "-d" || string(argv[1]) == "--downscale") { 
      shrink_fac = stoi(argv[2]);
      in_path = argv[3];
    }
    else
      usage_err();
  else if (argc == 2) {
    shrink_fac = 1;
    in_path = argv[1];
  }
  else 
    usage_err();  
  
  if (shrink_fac < 1) {
    cerr << "Error - downscale factor must be at least 1\n";
    return 1;
  }

  /* Try to load the image from the file path given */
  bitmap_image image(in_path);
  if (!image)
  {
    cerr << "Error - Failed to open: " << in_path << "\n";
    return 1;
  }

  /* Generate ouput filename from input path */
  string out_path;
  out_path = in_path.replace(in_path.find_last_of("."), in_path.length(), "_constraints.txt");
  if (in_path.find_last_of("/\\") != in_path.npos)
    out_path = out_path.substr(in_path.find_last_of("/\\") + 1);

  /* Try to open the output file */
  ofstream outfile;
  outfile.open (out_path);
  if (!outfile.is_open()) {
    cerr << "Error - Failed to write to file: " << out_path;
    return 1; 
  }

  /* Start actually finding and writing the constraints */
  cout << "Writing constraints to " << out_path << endl;

  const unsigned int height = image.height();
  const unsigned int width  = image.width();

  bool   found_color = false;
  for (size_t y = 0; y < height; y += shrink_fac) {
    for (size_t x = 0; x < width; x += shrink_fac) {
      
      rgb_t c;
      image.get_pixel(x, y, c);

      /* Find start of color region */
      if (c.red == 255 && !found_color) {
        found_color = true;
        outfile << "((vga_row >= 10d\"" << y 
                << "\" and vga_row < 10d\"" << y + shrink_fac
                << "\") and (vga_col >= 10d\"" << x 
                << "\" and vga_col < 10d\"";
      }
      
      /* Find end of color region */
      if (found_color) {
        if (c.red != 255) {
          found_color = false;
          outfile << x << "\")) or\n";
        }
        else if (x >= width - shrink_fac) {
          found_color = false;
          outfile << int(width) << "\")) or\n";
        }
      }
    }
  }  
  
  outfile.close();

  return 0;
}
