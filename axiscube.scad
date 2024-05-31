three=27;

module box() {
  translate([0, 0, three/2]) {
    color("blue") cube(size=[three, three, 1], center=true);
    rotate([0, 0, 90]) grid();
  }
  translate([0, three/2, 0])
  rotate([90, 0, 0]) {
    color("orange") cube(size=[three, three, 1], center=true);
    translate([0, 0, -1]) rotate([0, 0, 90]) grid();
  }
  translate([0, -three/2, 0])
  rotate([90, 0, 0]) {
    color("red") cube(size=[three, three, 1], center=true);
    rotate([0, 0, -90]) grid();
  }
  translate([-three/2, 0, 0])
  rotate([0, 90, 0]) {
    color("white") cube(size=[three, three, 1], center=true);
    translate([0, 0, -1]) rotate([0, 0, 90]) grid();
  }
  translate([three/2, 0, 0])
  rotate([0, 90, 0]) {
    color("yellow") cube(size=[three, three, 1], center=true);
    rotate([0, 0, -90]) grid();
  }
  translate([0, 0, -three/2]) {
    color("green") cube(size=[three, three, 1], center=true);
    translate([0, 0, -1]) rotate([0, 0, -90]) grid();
  }
}

module grid() {
  color("black")
  rotate([0, 0, 90])
  translate([-three/2, three/2, 0]) {
    ts2 = three*sqrt(2);
    rotate([0, 0, 45])
    translate([-ts2/2, -ts2/2, 0])
    cube([ts2, 0.5, 1]);

    rotate([0, 0, -45/2])
    cube([three*1.1, 0.5, 1]);

    rotate([0, 0, -(135/2)])
    cube([three*1.1, 0.5, 1]);

    rotate(45)
    translate([-three/3 -2, -ts2*(3/4) +1, 0])
    cube([three*0.85, 0.5, 1]);
  }
}

// rotate([45, 45, 0])
// rotate([90, 0, 0])
// rotate([90, 0, 0])
// rotate([90, 0, 0])
// rotate([0, 90, 0])
// rotate([0, 90, 0])
// rotate([0, 90, 0])
// rotate([0, 0, 90])
// rotate([0, 0, 90])
// rotate([0, 0, 90])
box();
