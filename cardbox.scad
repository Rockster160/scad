include <support/roundedcube.scad>
include <luffyjollyroger.scad>

include <support/in_to_mm.scad>
include <support/vars.scad>

wall = wall_size("flimsy");

doround=false;
thick_wall = wall*2;

tol = tolerance("loose");
tol2 = tol*2;

deck_w = 66;
deck_d = 17.5;
deck_h = 90;

spacing = 5;

box_w = deck_w + thick_wall*2 + spacing;
box_d = deck_d + thick_wall*2 + spacing;
box_h = deck_h + thick_wall*2 + spacing;

cut = 40; // How tall the base of the box is
slide = 15; // How much of an inner "slide" exists

clip_offset = 5; // How far in the slide the clip appears
clip_depth = 1; // How big the clip is

module clip(depth) {
  translate([0, rerr, clip_depth])
  rotate([0, 90, 0])
  linear_extrude(depth)
  polygon([
    [0,0],
    [clip_depth,-clip_depth],
    [clip_depth*2,0],
  ]);
}

module box() {
  difference() {
    union() {
      roundedcube([box_w, box_d, box_h-cut], doround=doround);

      translate([wall, wall, 0])
      roundedcube([box_w-thick_wall, box_d-thick_wall, box_h-cut+slide], doround=doround);
    }

    translate([thick_wall, thick_wall, wall])
    roundedcube([deck_w+spacing, deck_d+spacing, deck_h+spacing], doround=doround);

    translate([thick_wall*2 - tol, wall, box_h-cut+clip_offset])
    rotate([180, 0, 0])
    scale([1, 1.1, 1.1])
    clip(box_w-(thick_wall*4) + tol2);

    translate([thick_wall*2 - tol, box_d-thick_wall+wall, box_h-cut+clip_offset])
    scale([1, 1.1, 1.1])
    clip(box_w-(thick_wall*4) + tol2);
  }
}

module lid() {
  difference() {
    roundedcube([box_w, box_d, cut], doround=doround);

    translate([wall-tol, wall-tol, wall]) {
      roundedcube([box_w-thick_wall+tol2, box_d-thick_wall+tol2, cut], doround=doround);
    }
  }

  translate([thick_wall*2, wall-tol, cut-clip_offset])
  rotate([180, 0, 0])
  clip(box_w-(thick_wall*4));

  translate([thick_wall*2, wall-tol + box_d-thick_wall+tol2, cut-clip_offset])
  clip(box_w-(thick_wall*4));
}

// roundedcube([], doround=doround);
box();

// translate([0, box_d, box_h]) rotate([180, 0, 0])
translate([0, box_d+5, 0])
  lid();

translate([box_w/2, rerr, (box_h-cut)/2])
rotate([90, 0, 0])
scale([4, 4, 1]) {
  linear_extrude(2)
  skull();

  translate([0, 0, -box_d-2+rerr])
  linear_extrude(2)
  skull();
}
