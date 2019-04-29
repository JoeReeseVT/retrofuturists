#include <fstream>
#include <iostream>
#include "bitmap_image.hpp"

using namespace std;

int main(int argc, char *argv[]) {

  string path;

  if (argc != 2) {
    cerr << "Usage: " << argv[0] << "[-r] FILENAME\n";
    return(1);
  }
  else 
    path = argv[1];
  
  bitmap_image image(path);

  if (!image)
  {
    cerr << "Error - Failed to open: " << path << "\n";
    return 1;
  }

  for (int i = 0; i < 4; i++)
    path.pop_back();

  string out_path = "output\\" + path + "_constraints.txt";

  ofstream outfile;
  outfile.open (out_path);

  cout << "Writing constraints to " << out_path << endl;

  const unsigned int height = image.height();
  const unsigned int width  = image.width();

  bool   found_color = false;
  
  for (size_t y = 0; y < height; y += 4) {
    for (size_t x = 0; x < width; x += 4) {
      
      rgb_t c;
      image.get_pixel(x, y, c);

      if (c.red == 255 && !found_color) {
        found_color = true;
        outfile << "((vga_row >= 10d\"" << y 
                << "\" and vga_row < 10d\"" << y + 4
            		<< "\") and (vga_col >= 10d\"" << x 
                << "\" and vga_col < 10d\"";
      }

      if (found_color) {
        if (c.red != 255) {
          found_color = false;
          outfile << x << "\")) or\n";
        }
        else if (x == width - 1) {
          found_color = false;
          outfile << int(width) << "\")) or\n";
        }
      }
    }
  }  
  
  outfile.close();

  return 0;
}
