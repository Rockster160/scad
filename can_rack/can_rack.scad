use <../support/arc.scad>
use <../support/polyround.scad>
use <../support/in_to_mm.scad>
use <../support/infill_diamonds.scad>

$fn=60;

// 2 pieces, one full piece and one side piece. Can stack full pieces together for narrow walls.

// Max spacing
fridge_shelf_angle = 1;
fridge_w = in_to_mm(15);
fridge_d = in_to_mm(11.5);
fridge_h = in_to_mm(6.75);

foot_width = 40;

vert_margin = 30;
padding = 1;
wall = 3;
roller_angle = 2 + fridge_shelf_angle;
fit_tolerance = 0.45;

can_w = in_to_mm(2.6);
can_h = in_to_mm(4.83); // 122.682
can_lip_h = 20;
can_cap_w = in_to_mm(2.13);
cutout_space = fit_tolerance*4;

// can*3 = 368.046
// Fridge = 381
// Leftover space = 12.954
// | c | c | c |
// Walls can be 3, but must share walls.
side_cut_x = 168;
platform_cut_x = 130;
cut_width = 10;

can_hp = can_h + padding*2;
can_wp = can_w + padding*2;
can_pr = can_wp/2;

presentation_angle = 60;
roller_width = can_pr + wall;
presentation_arc_w = (roller_width + wall) * sin(presentation_angle);
// a / sin(A) == b / sin(B) == c / sin(C)
// b = (c / sin(C)) * sin(B)

module can() {
  translate([0, 0, padding]) {
    // With Padding
    translate([0, 0, -padding]) cylinder(r=can_pr, h=can_hp, $fn=60);
    // Can shape
    color("green") {
      cylinder(r=can_w/2, h=can_h, $fn=60);
    }
  }
}

module rollable_can() {
  translate([can_pr, can_pr, -can_hp])
  can();
}

module rolling_cans(cans, angle) {
  for (i=[0:cans-1]) {
    angle_lift = (0.5 + (can_wp*i)) * sin(angle);

    translate([wall/2 + (can_wp*i), wall*2 + angle_lift, 0])
      rollable_can();
  }
}

module slope(length, angle, wall_size) {
  translate([0, -wall_size/2, 0])
  rotate([0, 0, angle])
  square([length, wall_size]);
}

module roller_arc(inner_r, wall_size, angle) {
  translate([0, inner_r + wall, 0])
  rotate([0, 180, 90])
  arc(inner_r+wall, wall_size, angle, align="middle");
}

module bottom_roller(roller_depth, wall_size) {
  depth_between_arcs = roller_depth - presentation_arc_w - roller_width;

  translate([presentation_arc_w, 0, 0])
  roller_arc(can_pr, wall_size, presentation_angle);

  translate([presentation_arc_w, 0, 0])
  slope(depth_between_arcs, roller_angle, wall_size);

  back_arc_lift = depth_between_arcs * sin(roller_angle);

  translate([roller_depth - can_pr - wall*2, back_arc_lift, 0])
  roller_arc(can_pr, wall_size, -(90 + roller_angle/2));

  translate([roller_depth - wall - wall_size/2, back_arc_lift + can_pr, 0])
  square([wall_size, can_wp + can_lip_h]);
}

module top_roller(roller_depth, wall_size) {
  translate([0, vert_margin + can_wp, 0]) {
    slope(roller_depth - can_wp - wall*2, -roller_angle + fridge_shelf_angle, wall_size);
  }
}

module roller_outline(roller_depth, wall_size) {
  bottom_roller(roller_depth, wall_size);
  top_roller(roller_depth, wall_size);
}

module demo_cans() {
  translate([0, 0, 0.1]) {
    // Roller
    rolling_cans(4, roller_angle);
    // Bottom
    translate([-can_pr, roller_width/2 + 3, 0])
    rollable_can();
    // Top
    translate([-can_pr, vert_margin + can_wp + wall, 0])
    rollable_can();
  }
}

module full_side() {
  above_entry = vert_margin + can_wp + can_lip_h + wall*2;
  above_back = above_entry + can_pr;
  back_side = fridge_d - wall;
  points = [
    [0, 0, 10],
    [back_side, 0, 10],
    [back_side, above_back, 20],
    [0, above_entry, 20],
  ];
  translate([wall/2, wall/2, 0])
  polygon(polyRound(points));
}

module side_outline() {
  multiplier = 0.9;
  horz_offset = fridge_d * (1 - multiplier)/2;
  vert_offset = fridge_h * (1 - multiplier)/2;

  difference() {
    full_side();

    difference() {
      translate([horz_offset, vert_offset, 0])
      scale([multiplier, multiplier, 1])
      full_side();

      roller_outline(fridge_d - wall*2, can_lip_h);
    }
  }
}

module side() {
  side_outline();

  if (!$preview) {
    difference() {
      full_side();

      translate([fridge_d/2, fridge_h/2, 0])
      rotate([0, 0, 90])
      infill_diamonds(x=13, y=12, w=10, h=20, s=wall);
    }
  }
}

module extruded_side() {
  linear_extrude(wall) {
    intersection() {
      full_side();

      translate([side_cut_x - cut_width/2, 0, 0]) {
        square([cut_width, fridge_h]);
      }
    }

    difference() {
      side();

      difference() {
        translate([wall/2, wall*2, 0])
        roller_outline(fridge_d - wall*2, wall + fit_tolerance*2);

        square([10, fridge_h]);
      }
    }
  }

  linear_extrude(foot_width)
  intersection() {
    full_side();

    translate([0, 0, 0]) {
      square([fridge_d, wall]);
    }
  }
}

module fls() {
  difference() {
    extruded_side();

    translate([side_cut_x, 0, -0.1])
    cube([fridge_d, fridge_h, fridge_w]);
  }
}

module bls() {
  difference() {
    extruded_side();

    translate([-fridge_d + side_cut_x, 0, -0.1])
    cube([fridge_d, fridge_h, fridge_w]);
  }
}

module frs() {
  mirror([0, 1, 0]) {
    difference() {
      extruded_side();

      translate([side_cut_x, 0, -0.1])
      cube([fridge_d, fridge_h, fridge_w]);
    }
  }
}

module brs() {
  mirror([0, 1, 0]) {
    difference() {
      extruded_side();

      translate([-fridge_d + side_cut_x, 0, -0.1])
      cube([fridge_d, fridge_h, fridge_w]);
    }
  }
}

function sum(v, i = 0, r = 0) = i < len(v) ? add(v, i + 1, r + v[i]) : r;

cutouts = [
  5,
  10,
  20,
  50,
];

module cutout(w, h=fridge_h, d="both") {
  if (d == "both" || d == "l") {
    cube([w, h, wall]);
  }

  if (d == "both" || d == "r") {
    translate([w + cutout_space, 0, 0])
    cube([w, h, wall]);
  }
}

module connector_cutouts(d) {
  // Debugging
  // color("purple") {
  //   translate([side_cut_x - cut_width/2, 0, 0]) {
  //     square([cut_width, fridge_h]);
  //   }
  // }

  translate([12, -5, 0]) {
    translate([0, 0, 0]) cutout(5, d=d);
    translate([10 + cutout_space*2, 0, 0]) cutout(10, d=d);
    translate([10 + 20 + cutout_space*4, 0, 0]) cutout(20, d=d);
    translate([10 + 20 + 40 + cutout_space*6, 0, 0]) cutout(20, d=d);
    translate([10 + 20 + 40 + 40 + cutout_space*8, 0, 0]) cutout(11, d=d);

    jump = side_cut_x - cut_width/2;
    translate([jump, 0, 0]) cutout(6, d=d);
    translate([jump + 12 + cutout_space*2, 0, 0]) cutout(8, d=d);
    translate([jump + 12 + 16 + cutout_space*4, 0, 0]) cutout(25, 50, d=d);

    translate([fridge_d, 0, 0]) rotate([0, 0, 90]) {
      translate([0, 0, 0]) cutout(20, 35, d=d);
      translate([40 + cutout_space*2, 0, 0]) cutout(30, 35, d=d);
      translate([40 + 60 + cutout_space*4, 0, 0]) cutout(10, 35, d=d);
    }
  }
}

module platforms() {
  difference() {
    translate([0, 0, wall])
    linear_extrude(can_hp)
    roller_outline(fridge_d - wall*2, wall);

    roller_cutout = 10;
    hull() {
      translate([0, can_hp - wall, wall + can_hp - can_wp/2 - roller_cutout])
      rotate([90, 0, 0])
      can();

      translate([0, can_hp - wall, wall + can_wp/2 + roller_cutout])
      rotate([90, 0, 0])
      can();
    }
  }

  intersection() {
    connector_cutouts("r");
    // Debugging
    // # connector_cutouts("r");
    // % connector_cutouts("l");

    linear_extrude(wall)
    roller_outline(fridge_d - wall*2, wall);
  }

  translate([0, 0, can_hp+wall])
  intersection() {
    connector_cutouts("l");

    linear_extrude(wall)
    roller_outline(fridge_d - wall*2, wall);
  }
}

module plat_top() {
  difference() {
    platforms();

    translate([-1, -50, -1])
    cube([300, 100, 150]);

    translate([250, -50, -1])
    cube([100, 200, 150]);
  }
}

module plat_front() {
  difference() {
    platforms();

    translate([0, 50, -1])
    cube([300, 100, 150]);

    translate([platform_cut_x, 0, -1])
    cube([200, 100, 150]);
  }
}

module plat_back() {
  difference() {
    platforms();

    translate([0, 50, -1])
    cube([250, 100, 150]);

    translate([0, -50, -1])
    cube([platform_cut_x, 100, 150]);
  }
}


// translate([0, 0, -fridge_w])
// # cube([fridge_d, fridge_h, fridge_w]);

// fls();
// bls();
// frs();
// brs();

translate([wall/2, wall+wall, 0]) {
  // platforms();
  // plat_top();
  plat_front();
  // plat_back();
}
