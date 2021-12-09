use <support/in_to_mm.scad>
use <support/countersink.scad>
use <support/roundedcube.scad>

wall = 1;
base = 2;
tape_w = in_to_mm(2 + 1/4);
tape_d = in_to_mm(4 + 1/8);
tape_h = in_to_mm(4.83)/3;
pd = 3;
rerr = 0.01;

module centered_cube(size) {
  translate([-size.x/2, -size.y/2, 0])
  roundedcube([size.x, size.y, size.z]);
}

difference() {
  centered_cube([(tape_w + pd + wall*2), (tape_d + pd + wall*2), tape_h]);

  translate([0, 0, base]) {
    centered_cube([(tape_w + pd), (tape_d + pd), tape_h]);

    translate([0, 0, rerr])
    countersink(8,   3.5,  3.75,  31.5);
  }
}
