include <support/roundedcube.scad>
include <luffyjollyroger.scad>

include <support/in_to_mm.scad>
include <support/vars.scad>

innerwall = wall_size("flimsy");

doround = !$preview;
outerwall = innerwall*1.5;

tol = tolerance("loose");
tol2 = tol*2;

deck_w = 66;
deck_d = 17.5;
deck_h = 90;

spacing = 2;

box_w = deck_w + outerwall*2 + spacing;
box_d = deck_d + outerwall*2 + spacing;
box_h = deck_h + outerwall*2 + spacing;

cut = 40; // How tall the base of the box is
slide = 15; // How much of an inner "slide" exists

clip_offset = 5; // How far in the slide the clip appears
clip_depth = 0.6; // How big the clip is

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

      translate([outerwall/2, outerwall/2, 0])
      roundedcube([box_w-outerwall, box_d-outerwall, box_h-cut+slide], doround=doround);
    }

    translate([outerwall, outerwall, innerwall])
    roundedcube([deck_w+spacing, deck_d+spacing, deck_h+spacing], doround=doround);

    translate([outerwall*2 - tol, outerwall/2, box_h-cut+clip_offset])
    rotate([180, 0, 0])
    scale([1, 1.1, 1.1])
    clip(box_w-(outerwall*4) + tol2);

    translate([outerwall*2 - tol, box_d-outerwall+outerwall/2, box_h-cut+clip_offset])
    scale([1, 1.1, 1.1])
    clip(box_w-(outerwall*4) + tol2);
  }
}

module lid() {
  difference() {
    roundedcube([box_w, box_d, cut], doround=doround);

    translate([(outerwall/2)-tol, (outerwall/2)-tol, innerwall]) {
      roundedcube([box_w-outerwall+tol2, box_d-outerwall+tol2, cut], doround=doround);
    }
  }

  translate([outerwall*2, (outerwall/2)-tol, cut-clip_offset])
  rotate([180, 0, 0])
  clip(box_w-(outerwall*4));

  translate([outerwall*2, (outerwall/2)-tol + box_d-outerwall+tol2, cut-clip_offset])
  clip(box_w-(outerwall*4));
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
