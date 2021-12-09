include <support/in_to_mm.scad>
include <support/roundedcube.scad>

wall = 1;
r_err = 0.01;

w = in_to_mm(5);
d = in_to_mm(2.5);
h = in_to_mm(2);

difference() {
  roundedcube([w + wall*2, d + wall*2, h + wall - r_err], radius=2);

  translate([wall, wall, wall])
  roundedcube([w, d, h+5], radius=2);
}
