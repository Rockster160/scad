include <support/vars.scad>
include <support/in_to_mm.scad>
include <support/roundedcube.scad>

spacing = in_to_mm(1.25);
clasp = 10;
wall = wall_size("flimsy");

module hole() {
  cylinder(r=2, h=wall+rerr*2);
}

difference() {
  roundedcube([spacing+clasp, spacing+clasp, clasp], center=false, radius=2);

  translate([wall, wall, wall])
  cube([spacing*2, spacing*2, spacing*2]);

  translate([spacing, spacing, 0])
  hole();
}
