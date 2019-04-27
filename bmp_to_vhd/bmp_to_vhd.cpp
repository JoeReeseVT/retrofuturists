/*  Convert a bitmap image to VHDL code for outputting to VGA.
 *
 *  DO NOT USE THIS PROGRAM WITHOUT VIEWING THE README.
 *
 *  Author(s):
 *    Joe
 *
 *  Version 0.1.1
 *  Modified by Joe 27 Apr 2019:
 *    Made it do half resolution for slightly less complex logic.
 */

#include <cstdio>
#include <fstream>
#include "bitmap_image.hpp"

using namespace std;

int main() {
  bitmap_image image("track.bmp");

  if (!image)
  {
    printf("Error - Failed to open: input.bmp\n");
    return 1;
  }
  
  ofstream outfile;
  outfile.open ("constraints.txt");

  const unsigned int height = image.height();
  const unsigned int width  = image.width();

  bool found_color = false;

  unsigned char ref [3] = {0, 170, 0};
  outfile << "\"001000\" when\n";

  for (size_t y = 0; y < height; y += 2) {
    for (size_t x = 0; x < width; x++) {
      
      rgb_t c;
      image.get_pixel(x, y, c);

      if (c.red == ref[0] && c.green == ref[1] && c.blue == ref[2]
      && !found_color) {
        found_color = true;
        outfile << "((vga_row = 10d\"" << y << "\" or vga_row = 10d\"" << y + 1
		<< "\") and (vga_col >= 10d\"" << x << "\" and vga_col < 10d\"";      }

      if (found_color) {
        if (c.red != ref[0] || c.green != ref[1] || c.blue != ref[2]) {
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
