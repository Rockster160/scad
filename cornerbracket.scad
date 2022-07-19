include <support/vars.scad>
include <support/roundedcube.scad>
include <support/countersink.scad>

inch = 25.4;
wall = wall_size("weak");

screw_offset = inch/2 + wall/4;

module screw() {
  countersink(6.2, 2.3, 3.5, 6);
  // translate([0, 0, -5])
  // cylinder(r=3, h=10);
}

difference() {
  roundedcube([inch, inch, inch], center=false, radius=2);

  translate([wall, wall, wall])
  cube([inch, inch, inch]);

  translate([screw_offset, screw_offset, wall + rerr])
  screw();

  rotate([90, 0, 90])
  translate([screw_offset, screw_offset, wall + rerr])
  screw();

  rotate([-90, -90, 0])
  translate([screw_offset, screw_offset, wall + rerr])
  screw();
}
// translate([0, 0, -inch/4])
// cube([inch, inch, inch/4]);
