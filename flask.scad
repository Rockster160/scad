include <support/vars.scad>
include <support/in_to_mm.scad>

w = in_to_mm(4);
d = in_to_mm(8);
h = in_to_mm(3);

wall = wall_size("solid");

slot_w = 20;
slot_padding = 2;
slot_r = slot_w/2 - slot_padding*2;
con_h = 20;
tolerance = 0.45;

module box() {
  difference() {
    cube([w, d, h]);

    translate([wall, wall, -0.01])
    cube([w - wall*2, d - wall*2, h+1]);
  }

  module corner() {
    cube([slot_w, slot_w, h]);
  }

  translate([0, 0, 0])                   corner();
  translate([w - slot_w, 0, 0])          corner();
  translate([0, d - slot_w, 0])          corner();
  translate([w - slot_w, d - slot_w, 0]) corner();
}

module mcon() {
  cylinder(r=slot_r, h=con_h - slot_r);
  translate([0, 0, con_h - slot_r]) sphere(r=slot_r);
}

module mbox() {
  translate([0, 0, h]) {
    translate([slot_w/2, slot_w/2, 0])  mcon();
    translate([w - slot_w/2, slot_w/2, 0])  mcon();
    translate([w - slot_w/2, d - slot_w/2, 0])  mcon();
    translate([slot_w/2, d - slot_w/2, 0])  mcon();
  }

  box();
}

module fcon() {
  rotate([0, 180, 0]) {
    cylinder(r=slot_r + tolerance, h=con_h - slot_r + tolerance);
    translate([0, 0, con_h - slot_r]) sphere(r=slot_r + tolerance);
  }
}

module fbox() {
  difference() {
    box();

    translate([0, 0, h+0.01]) {
      translate([slot_w/2, slot_w/2, 0]) fcon();
      translate([w - slot_w/2, slot_w/2, 0]) fcon();
      translate([w - slot_w/2, d - slot_w/2, 0]) fcon();
      translate([slot_w/2, d - slot_w/2, 0]) fcon();
    }
  }
}

mbox();

translate([w+5, 0, 0])
fbox();
