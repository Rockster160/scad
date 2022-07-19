include <support/vars.scad>
include <support/countersink.scad>
include <support/in_to_mm.scad>

opening = in_to_mm(3.1);
break = in_to_mm(2.1);
wall = wall_size("solid");
// full_clip = in_to_mm(6 - 1 - 1.5);
full_clip = opening + wall*2;
small_depth = in_to_mm(4);
depth = in_to_mm(4);

closing_c = in_to_mm(2.5);
closing_c_depth = in_to_mm(1);

module screw() {
  translate([full_clip/2, wall, 0])
  rotate([-90, 0, 0])
  countersink(8.5,   4,  3.75,  31.5, 1);
}

module thing() {
  difference() {
    hull() {
      translate([0, -35, 2])
      rotate([-20, 0, 0])
      cube([full_clip, wall, small_depth]);

      translate([full_clip/2, opening/2 + wall, 0])
      cylinder(r=opening/2 + wall, h=small_depth);
    }

    translate([full_clip/2, opening/2 + wall, 0])
    translate([0, 0, -5])
    cylinder(r=opening/2, h=small_depth+10);

    translate([full_clip/2, opening + in_to_mm(0.5), in_to_mm(1)])
    translate([0, 0, break/2])
    rotate([90, 0, 0])
    linear_extrude(in_to_mm(1))
    hull() {
      circle(r=break/2);
      translate([0, small_depth, 0])
      circle(r=break/2);
    }

    translate([0, 0, small_depth/3])
    #screw();

    translate([0, 0, small_depth/3 * 2])
    #screw();
  }
}

thing();
// rotate([-90+20, 0, 0]) {
// }
