include <support/arc_rad_from_wh.scad>
include <support/arc.scad>

w = 155;
h = 81.5;
offset = 5;
wo = w + offset;
ho = h + offset;
sw = w - offset;
sh = h - offset;
wall = 2;

arc_rad = arc_rad_from_wh(w - offset, h - offset);

module hole() {
  difference() {
    circle(r=sw/2);

    translate([-wo/2, -sw/2 + h, 0])
    square([wo, wo]);
  }
}

linear_extrude(wall)
resize([wo + 10, ho + 10, 1]) {
  hole();
}

translate([0, -5, wall])
linear_extrude(wall*2)
difference() {
  resize([w, h, 1]) {
    hole();
  }

  resize([w - wall, h - wall, 1]) {
    hole();
  }
}
