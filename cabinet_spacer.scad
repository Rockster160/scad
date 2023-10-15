include <support/vars.scad>
include <support/and_mirror.scad>
include <support/in_to_mm.scad>

dist = 28.3;
length = in_to_mm(3 + (15/16));


andMirror([1, 0, 0]) {
  translate([dist + wall*2, 0, 0]) {
    difference() {
      translate([-dist, -dist, 0])
      cube([dist*2, dist*2 + length, wall]);

      cylinder(r=3/2, h=10, center=true, $fn=60);

      translate([0, length, 0])
      cylinder(r=3/2, h=10, center=true, $fn=60);
    }

    translate([-dist-wall+rerr, -dist-wall, 0])
    cube([wall, dist*2+wall, 10]);

    translate([-dist-wall, -dist-wall+rerr, 0])
    cube([dist*2+wall, wall, 10]);
  }
}

// translate([-dist-rerr, 0, 0])
// cube([wall, dist+wall, 10]);
//
// translate([0, -dist-rerr, 0])
// cube([dist+wall, wall, 10]);
