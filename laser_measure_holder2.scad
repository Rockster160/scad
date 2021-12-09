$fn = 20;
include <support/in_to_mm.scad>
include <support/countersink.scad>
include <support/minkowskiRound.scad>

round_d = 1;
t = 3 + round_d;
rerr = 0.01;
wall = 2;
dwall = wall*2;

w = 50.2 + t;
d = 25 + t;
h = 80 + t;

cutout_r = (w/2)/4 * 3;

module shell(size, wall) {
  difference() {
    cube([size.x + dwall, size.y + dwall, size.z + dwall]);

    translate([wall, wall, wall])
    cube([size.x, size.y, size.z + dwall]);
  }
}

module case() {
  minkowskiRound(round_d, round_d, $preview ? 0 : 1)
  difference() {
    shell([w, d, h], wall);

    translate([w/2 + wall, wall+rerr, (h+wall)/2 + cutout_r])
    rotate([90, -90, 0])
    linear_extrude(wall*2)
    hull() {
      circle(r=cutout_r);

      translate([w, 0, 0])
      circle(r=cutout_r);
    }
  }
}

difference() {
  case();

  #translate([(w+dwall)/2, d+wall, (h+dwall) - in_to_mm(1.5)/2])
  rotate([90, 0, 0])
  gold_countersink(t=0.5, d=1);
}
