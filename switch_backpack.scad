include <support/in_to_mm.scad>
include <support/arc.scad>

w = in_to_mm(6.5);
h = in_to_mm(4);
d = 14;

gw = 21.25;
gd = 3.4;
gh = 30;

wall = 2;

latch = 5.5;

t = 0.5; // tolerance

rt = 0.01; // Rounding tolerance

curve_r = 6.4;

hook_connector_distance = d - curve_r*2;

// % cube([w, d, h]);
// # cube([gw, gd, gh]);

module hook() {
  arc(curve_r, wall, 90, align="inside");

  translate([curve_r, -hook_connector_distance - rt, 0])
  square([wall, hook_connector_distance + rt*2]);

  translate([0, -hook_connector_distance, 0])
  rotate([0, 0, -90])
  arc(curve_r, wall, 90, align="inside");
}

// cube([w, wall, h]);

rotate([0, 90, 0]) linear_extrude(latch) {
  translate([0, curve_r, 0])
  square([h - curve_r*2, wall]);

  translate([h - curve_r*2, 0, 0])
  hook();

  translate([0, -hook_connector_distance, 0])
  rotate([0, 0, 180])
  hook();
}
