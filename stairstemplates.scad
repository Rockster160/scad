include <support/in_to_mm.scad>
include <support/linepath.scad>

run = in_to_mm(5.28472);
rise = in_to_mm(4.6875);
angle = 41.5727;

overhang = in_to_mm(2);
base = 3;
wall = 3;
clip = 10;

module baset() {
  polygon([
    [0, 0],
    [overhang+wall, 0],
    [overhang+wall + overhang*cos(angle), overhang * sin(angle)],
  ]);
}

module stairt() {
  polygon([
    [-wall, 0],
    [run, rise+wall],
    [run, 0],
    ]);
}

module base() {
  mirror([0, 1, 0]) {
    linear_extrude(base)
    difference() {
    baset();
      # offset(delta=-wall) baset();
    }

    linear_extrude(clip)
    translate([overhang+wall, 0, 0])
    rotate([0, 0, angle]) {
      square([overhang, wall]);
    }
  }
}

module stair() {
  mirror([0, 1, 0]) {
    linear_extrude(base)
    difference() {
      stairt();

      # offset(delta=-wall*2) stairt();
    }

    linear_extrude(clip)
    rotate([0, 0, angle]) {
      square([sqrt(pow(rise, 2) + pow(run, 2)), wall]);
    }
  }
}

base();
/* stair(); */
