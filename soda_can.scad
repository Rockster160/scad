include <support/in_to_mm.scad>

can_w = in_to_mm(2.6);
can_h = in_to_mm(4.83); // 122.682
can_lip_h = 20;
can_cap_w = in_to_mm(2.13);

module quick_can() {
  color("green") {
    cylinder(r=can_w/2, h=can_h);
  }
}

module can() {
  color("green") {
    // Bottom Lip
    cylinder(3, 48/2, 53/2);

    // Base slide
    translate([0, 0, 3])
    cylinder(6, 53/2, can_w/2);

    // Side
    translate([0, 0, 9])
    cylinder(96, can_w/2, can_w/2);

    // Top Slide
    translate([0, 0, 105])
    cylinder(16, can_w/2, 52.5/2);

    // Top Lip
    translate([0, 0, 121])
    cylinder(2, 53.5/2, 53.5/2);
  }
}

quick_can();
// can();
