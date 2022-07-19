include <support/vars.scad>

wall = wall_size("flimsy");

btn_slot = 15.6;
d = 30;
wall2 = wall*2;
dw = d + wall;

include <support/roundedcube.scad>

difference() {
  roundedcube([d, d, d]);

  translate([wall, wall, wall])
  roundedcube([d - wall2, d - wall2, d - wall2]);

  translate([d/2, 0, d/2])
  rotate([90, 0, 0])
  cylinder(r=btn_slot/2, h=10, center=true);

  translate([d/2, dw, d/2])
  rotate([90, 0, 0])
  cylinder(r=2, h=10, center=true);

  translate([d/2, wall+0.01, d/2])
  rotate([90, 0, 0])
  cylinder(r=21/2, h=wall/2, $fn=6);

  translate([wall, d-wall*4, 0])
  cube([d-wall2, 5, 10]);

  translate([d/2 - 2, d-wall*4, 0])
  cube([4, 10, 4]);
}
