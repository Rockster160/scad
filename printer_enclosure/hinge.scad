// Next Time: Reduce tolerance to 0.4? -- Only at standard print resolution.
a

include <../support/polyround.scad>
include <../support/countersink.scad>

r_err = 0.01;
tolerance = 0.55;

$fn = 100;

wall = 3;

w = 20;
h = 60;

bolt_r = 3;
bolt_h = h/2 - wall;
bolt_sleeve_r = bolt_r + wall/3 + tolerance;

// roundedcube(size=[w, wall, h], center=false, radius=1);
module base_bracket() {
  points = polyRound([
      [0, 0, 10],
      [w + bolt_sleeve_r, 0, 0],
      [w + bolt_sleeve_r, h, 0],
      [0, h, 10],
    ]);

    translate([0, wall, 0])
    rotate([90, 0, 0])
    linear_extrude(wall)
    polygon(points);
}

module screw() {
  rotate([-90, 0, 0])
  countersink(7.5, 3,    3.8,   18.75);
}

module bracket() {
  difference() {
    union() {
      base_bracket();

      translate([w + bolt_sleeve_r/2, 0, -r_err/2])
      cylinder(r=bolt_sleeve_r, h=h/2);
    }

    translate([w + bolt_sleeve_r/2, 0, h/2])
    cylinder(r=bolt_sleeve_r + tolerance, h=h/2+r_err);

    translate([w/2, -r_err, h*0.8])
    screw();

    translate([w/2, -r_err, h*0.2])
    screw();
  }
}

module fbracket() {
  difference() {
    bracket();

    translate([w + bolt_sleeve_r/2, 0, wall+r_err])
    cylinder(r=bolt_r + tolerance, h=bolt_h);
  }
}

module mbracket() {
  bracket();

  translate([w + bolt_sleeve_r/2, 0, h/2])
  cylinder(r=bolt_r, h=bolt_h);
}

translate([w + bolt_sleeve_r, -bolt_sleeve_r - wall/2, 0])
rotate([0, 0, 180])
  fbracket();

mbracket();
