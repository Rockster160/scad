// Make thicker walls?

include <support/roundedcube.scad>
include <luffyjollyroger.scad>

include <support/in_to_mm.scad>
include <support/vars.scad>

wall = wall_size("weak");
tol = 5;//tolerance("friction");
doround=false;
wall2 = wall*2;

box_w = 65 + (tol*3);
box_d = 17.5 + (tol*3);
box_h = in_to_mm(3 + 9/16) + (tol*3);

cut = 40;
slide = 15;

difference() {
  union() {
    translate([wall/2, wall/2, wall/2])
    roundedcube([box_w+wall-tol, box_d+wall-tol, box_h+wall - cut + slide], doround=doround);

    roundedcube([box_w+wall2, box_d+wall2, box_h+wall2 - cut], radius=2, apply_to="zmin", doround=doround);
  }

  translate([wall, wall, wall])
  cube([box_w, box_d, box_h]);
}

translate([0, box_d + (wall2*2), 0])
difference() {
  roundedcube([box_w+wall2, box_d+wall2, cut], radius=2, apply_to="zmin", doround=doround);

  translate([wall/2 - tol/2, wall/2 - tol/2, wall/2])
  cube([box_w+wall + tol, box_d+wall + tol, cut]);

  translate([wall, wall, wall])
  cube([box_w, box_d, box_h]);
}

// translate([(box_w+wall2)/2, 1, (box_h+wall2 - cut)/2])
// rotate([90, 0, 0])
// scale([4, 4, 1])
// linear_extrude(2)
// skull();
//
// translate([(box_w+wall2)/2, box_d+wall2+1, (box_h+wall2 - cut)/2])
// rotate([90, 0, 0])
// scale([4, 4, 1])
// linear_extrude(2)
// skull();
