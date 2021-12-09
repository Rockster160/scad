use <support/in_to_mm.scad>
use <support/countersink.scad>

wall = 1;
base = 2;
box_w = in_to_mm(4);
box_d = in_to_mm(8);
box_h = 20;
pd = 3;
rerr = 0.01;

module centered_cube(size) {
  translate([-size.x/2, -size.y/2, 0])
  cube([size.x, size.y, size.z]);
}

difference() {
  centered_cube([(box_w + pd + wall*2), (box_d + pd + wall*2), box_h]);

  translate([0, 0, base]) {
    centered_cube([(box_w + pd), (box_d + pd), box_h]);

    translate([0, 0, rerr])
    countersink(8,   3.5,  3.75,  31.5);
  }
}
