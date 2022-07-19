include <support/vars.scad>
include <support/in_to_mm.scad>

wall = wall_size("weak");

box_w = in_to_mm(6);
box_d = in_to_mm(4);
box_h = in_to_mm(3);

module fan() {
  color("black")
  cube([40, 40, 10]);
}

module heatsink() {
  color("silver")
  cube([30, 40, 5]);
}

module heat_element() {
  color("red")
  cube([30, 40, 0.5]);
}

module heater() {
  heatsink();
  translate([0, 0, 5])
  heat_element();
}

module butter_box() {
  difference() {
    color("white")
    cube([box_w + wall*2, box_d + wall*2, box_h + wall]);

    translate([wall, wall, wall+r_err])
    cube([box_w, box_d, box_h]);
  }
}

butter_box();
translate([0, 0, box_h]) {

  translate([box_w - 45, box_d/2 - 20, 0])
  fan();

  translate([box_w/2 - 15, box_d/2 - 20, 0])
  heater();
}
