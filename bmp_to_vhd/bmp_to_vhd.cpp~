/*  Convert a bitmap image to VHDL code for outputting to VGA.
 *
 *  DO NOT USE THIS PROGRAM WITHOUT VIEWING THE README.
 *
 *  Author(s):
 *    Joe
 *
 *  Version 0.1.0
 *  Modified by Joe 16 Apr 2019
 */

#include <cstdio>
#include <iostream>
#include "bitmap_image.hpp"

using namespace std;

int main() {
  bitmap_image image("track.bmp");

  if (!image)
  {
    printf("Error - Failed to open: input.bmp\n");
    return 1;
  }
  
  const unsigned int height = image.height();
  const unsigned int width  = image.width();

  bool found_color = false;

  unsigned char ref [3] = {0, 170, 0};
  cout << "\"001000\" when\n";

  for (size_t y = 0; y < height; y++) {
    for (size_t x = 0; x < width; x++) {
      
      rgb_t c;
      image.get_pixel(x, y, c);

      if (c.red == ref[0] and c.green == ref[1] and c.blue == ref[2]
      and not found_color) {
        found_color = true;
        cout << "(vga_row = 10d\"" << y << "\" and (vga_col >= 10d\"" << x;
      }

      if (found_color) {
        if (c.red != ref[0] or c.green != ref[1] or c.blue != ref[2]) {
          found_color = false;
          cout << "\" and vga_col < 10d\"" << x << "\")) or\n";
        }
        else if (x == width - 1) {
          found_color = false;
          cout << "\" and vga_col < 10d\"" << int(width) << "\")) or\n";
        }
      }
    }
  }

  return 0;
}
