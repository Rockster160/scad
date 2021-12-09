use <support/arc_rad_from_wh.scad>
use <support/in_to_mm.scad>

width = in_to_mm(7.5625);
depth = 31;

outer_rad = arc_rad_from_wh(width, depth);

wall = 1;
inner_width = 4.5;
full_width = 100;
clip_height = 20;

module arc(w, h, d) {
  $fn = 100;
  difference() {
    translate([0, outer_rad, 0]) cylinder(r=outer_rad, h=h);

    translate([0, outer_rad, 0]) translate([0, d, -0.5]) cylinder(r=outer_rad, h=h+1);

    translate([w/2, 0, -0.5]) cube([outer_rad, outer_rad*2, h+1]);
    translate([-w/2 - outer_rad, 0, -0.5]) cube([outer_rad, outer_rad*2, h+1]);
  }
}

module space_arc() {
  translate([0, wall, wall]) {
    arc(full_width+1, clip_height, inner_width);
  }
}

module full() {
  // -- Shower Clip
  difference() {
    arc(full_width, clip_height, inner_width + wall*2);

    space_arc();
  }

  // -- Electric Razor
  razor_width = 37.8;
  razor_depth = 30;
  razor_height = clip_height;
  razor_walls = 3;

  rotate([0, 0, 8]) {
    translate([0, -razor_depth, 0]) {
      difference() {
        cube([razor_width + razor_walls*2, razor_depth, razor_height]);

        translate([razor_walls, -1, -0.5])
          cube([razor_width, razor_depth, razor_height+1]);
      }
    }
  }

  // -- Manual Razor
  mr_w = 16;
  mr_d = 12;
  mr_h = clip_height;
  mr_a_w = 3;
  mr_a_h = 5;
  walls = 3;

  rotate([0, 0, -5]) {
    translate([-mr_w - walls - 8, -mr_d, 0]) {
      difference() {
        cube([mr_w + walls*2, mr_d, mr_h]);

        translate([walls, -0.5, -0.5])
        cube([mr_w, mr_d+0.5, mr_h+1]);
      }

      translate([mr_w/2 + walls - mr_a_w/2, 0, 0])
      cube([mr_a_w, mr_d, mr_a_h]);
    }
  }
}

// translate([0, 0, clip_height]) rotate([0, 180, 0])
  full();
