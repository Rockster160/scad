include <support/scale_to.scad>

$fn = 60;

// module icon(file, frame_offset) {
//   translate([0, 0, -frame_offset]) {
//     difference() {
//       scale([1, 1, 0.3])
//       resize([0, 0, 5], auto=true)
//       surface(file=file, convexity=1, center=true);
//
//       translate([0, 0, -1.5 + frame_offset])
//       cube([250, 250, 3], center=true);
//     }
//   }
// }

module andMirror(dirs) {
  mirror(dirs)
  children();
  children();
}

module donut(r, wall) {
  difference() {
    circle(r);
    circle(r-wall);
  }
}

module bone() {
  size=[1, 13.5];
  r = 0.6;

  rotate([0, 0, -45])
  translate([-size.x/2, -size.y/2, 0])
  square([size.x, size.y]);

  x = size.y/2 * cos(-45);
  y = size.y/2 * sin(-45);

  module ball() {
    translate([x + r/2, y + r/2, 0])
    circle(r);

    translate([x - r/2, y - r/2, 0])
    circle(r);
  }
  mirror([0, 1, 0])
  mirror([1, 0, 0])
  ball();
  ball();
}

module head() {
  circle(3.5);
}

module crossbones() {
  translate([0, 0, 0]) {
    bone();

    rotate([0, 0, 90])
    bone();
  }
}

module outline() {
  donut(3.5 + 0.2, 0.2);
}

module eyes() {
  andMirror([1, 0, 0])
  translate([1.6, -1.15, 0])
  circle(r=1.2);
}

module mouth() {
  difference() {
    translate([0, -4.35, 0])
    circle(1.6);

    donut(4.2, 0.2);
    donut(4.8, 0.2);

    teeth_angles = [165, 175, 185, 195];
    for (i=teeth_angles) {
      rotate([0, 0, i])
      translate([-0.1, 0, 0])
      square([0.2, 4.8]);
    }
  }
}

module nose() {
  translate([0, -2.5, 0])
  circle(r=0.5);
}

module band() {
  difference() {
    translate([0, 0.14, 0])
    resize([0, 4, 0])
    circle(r=6);

    difference() {
      translate([0, 0.14, 0])
      resize([0, 3.5, 0])
      circle(r=6);

      translate([0, 0.14, 0])
      resize([0, 2, 0])
      circle(r=6);
    }

    hat();

    translate([-5, -10+0.4, 0])
    square(size=[10, 10]);
  }
}

module hat() {
  translate([0, 0.4, 0])
  resize([0, 1, 0])
  circle(r=6);
}

module skull() {
  difference() {
    union() {
      hat();
      head();
      crossbones();
      mouth();
    }
    band();

    difference() {
      outline();
      hat();
    }

    eyes();
    nose();
  }
}


// %icon("/Users/rocco/Downloads/luffyflag.png", 0.05);
//   icon("/Users/rocco/Downloads/zoroflag.png", 0.01);
