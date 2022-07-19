include <support/vars.scad>
include <support/roundededge.scad>
include <support/countersink.scad>
include <support/in_to_mm.scad>

wall = wall_size("solid");
w = 15;
d = 35;
h = in_to_mm(1/4 + 1/16);


difference() {
  cube([w, d, h + wall]);

  translate([w/2, w/2, -rerr])
  rotate([180, 0, 0])
  gold_countersink();

  translate([-rerr, w, wall])
  cube([w+1, d+1, h+1]);

  translate([0, 0, h + wall])
  rotate([0, 90, 0])
  chamfer(3, w);

  translate([0, w, h + wall])
  mirror([1, 0, 0])
  rotate([180, 90, 0])
  chamfer(3, w);

  mirror([1, 0, 0])
  rotate([0, 270, 0])
  chamfer(3, w);

  translate([0, d, 0])
  rotate([180, 270, 0])
  chamfer(3, w);

  translate([0, d, wall])
  mirror([1, 0, 0])
  rotate([180, 90, 0])
  chamfer(3, w);
}
translate([0, w, wall])
mirror([1, 0, 0])
rotate([0, -90, 0])
fillet(2, w);
