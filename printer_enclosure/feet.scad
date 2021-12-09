include <../support/in_to_mm.scad>

wall = 4;
tolerance = 0.8;
r_err = 0.01;

desired_height = in_to_mm(20) + wall + tolerance*2;
// 15/16 = 0.9375

sheet_d = 2.25;
sheet_holder_w = 30;

plat_h = in_to_mm(15 + 15/16); // 15.9375
plat_w = in_to_mm(21 + 5/8); // 26.875

leg_h = in_to_mm(15 + 3/4); // 15.75
// leg_w = in_to_mm(1 + 15/16) + tolerance; // 1.9375 -- 49.2125mm
leg_w = 50.4;
// (49.2125 + 0.5 - 49.7)
// Part: 49
// Leg: 50.4

overflow_h = 20;
foot_h = desired_height - leg_h;

// 26.875 - (1.9375 * 2)
module leg() {
  difference() {
    translate([-wall, -wall, 0]) {
      cube([leg_w + wall*2, leg_w + wall*2, foot_h + overflow_h]);
    }

    translate([0, 0, foot_h])
    cube([leg_w, leg_w, foot_h + overflow_h]);

    translate([leg_w-r_err, 0, foot_h])
    cube([leg_w/2, leg_w/2, foot_h + overflow_h]);

    translate([0, leg_w-r_err, foot_h])
    cube([leg_w/2, leg_w/2, foot_h + overflow_h]);
  }
}

module triangle() {
  points = [
    [0, 0],
    [0, sheet_holder_w],
    [sheet_holder_w, 0],
  ];

  rotate([90, 0, 0])
  linear_extrude(wall)
  polygon(points);
}

module clasp() {
  clasp_d = wall*2 + sheet_d + tolerance;

  translate([0, wall, wall/2]) {
    triangle();

    translate([0, sheet_d + tolerance + wall, 0])
    triangle();
  }

  cube([sheet_holder_w, clasp_d, wall/2 + r_err]);
}

module front_clasp() {
  translate([wall + sheet_d + tolerance, leg_w + wall - r_err, 0])
  rotate([0, 0, 90])
  clasp();
}

module back_clasp() {
  translate([leg_w + wall - r_err, -wall, 0])
  clasp();
}

module actual() {
  leg();
  front_clasp();
  back_clasp();

  translate([-10, 0, 0]) rotate([0, 0, 90]) {
    leg();
    front_clasp();
    back_clasp();
  }

  translate([-10, -10, 0]) rotate([0, 0, 180]) {
    leg();
    back_clasp();
  }
  translate([0, -10, 0]) rotate([0, 0, -90]) {
    leg();
    front_clasp();
  }
}

module demo() {
  translate([0, 0, -foot_h + wall])
  difference() {
    leg();

    translate([-leg_w/2, -leg_w/2, -r_err])
    cube([leg_w*2, leg_w*2, foot_h - wall]);
  }
  front_clasp();
}

// actual();
demo();
