include <support/vars.scad>
use <support/arc.scad>
use <support/polyround.scad>
use <support/in_to_mm.scad>
use <support/infill_diamonds.scad>

$fn=60;

// Next print:
// Reduce padding by half?
// Raise french cleat!!
// Thicker walls?
padding=1;
wall = wall_size("weak");

can_w = 53;
can_h = in_to_mm(5 + 5/16);
slope_end_angle = -85;
slope_presenter_multiplier = 1.5;

can_wp = can_w + padding*2;
can_hp = can_h + padding*2;
can_pr = can_wp/2;

pipe_length = can_wp * 2.5;
inner_slope_w = (can_wp*3)/2;

outer_slope_w = wall + inner_slope_w + wall;

inner_slope_start_x = (inner_slope_w + wall) * cos(slope_end_angle);
inner_slope_start_y = (inner_slope_w + wall) * sin(slope_end_angle);
ramp_length = can_wp * slope_presenter_multiplier;
ramp_edge_offset_y = ramp_length * cos(slope_end_angle);
ramp_edge_offset_x = ramp_length * sin(slope_end_angle);
ramp_edge_point_x = can_pr * cos(180 + slope_end_angle);
ramp_edge_point_y = can_pr * sin(180 + slope_end_angle);

holster_w = wall + can_hp + wall;

module cleat(h) {
  width = in_to_mm(0.5);
  points = [
    [-wall, h, 1],
    [width, h, 1],
    [width, -width, 1],
    [0, -wall, 1],
    [0, -width, 1],
    [-wall, -width, 1],
  ];
  polygon(polyRound(points, 30));
}

module can() {
  translate([0, 0, padding]) {
    // With Padding
    % translate([0, 0, -padding]) cylinder(r=can_pr, h=can_hp, $fn=60);
    // Can shape
    rgb(0, 255, 0) {
      cylinder(r=can_w/2, h=can_h, $fn=60);
    }
  }
}

module roller() {
  union() {
    // Value to determine length of flat roller that comes away from the slope
    arc(inner_slope_w, wall, slope_end_angle);

    translate([inner_slope_start_x, inner_slope_start_y, 0]) {
      rotate([0, 0, 180 + slope_end_angle])
      square([wall, ramp_length]);

      translate([ramp_edge_offset_x, -ramp_edge_offset_y, 0])
      rotate([0, 0, 90 + slope_end_angle])
      square([wall, can_pr]);
    }
  }
}

module frame_walls() {
  union() {
    roller();
    // inner slope
    arc(can_pr - wall, wall, -90);
    // Wall
    translate([can_pr - wall, 0, 0])
    square([wall, pipe_length - can_pr]);
    // Lip
    translate([0, pipe_length - can_pr, 0])
    arc(can_pr - wall, wall, 90);
    // Wall
    translate([can_wp + can_pr, 0, 0])
    square([wall, pipe_length]);
  }
}

module frame() {
  points = [
    [0, -can_pr + wall, 1],
    [can_pr - wall, -can_pr, 45],
    [can_pr - wall, 0, 1],
    [can_pr - wall, pipe_length - wall, 90],
    [0, pipe_length - wall, 1],
    [0, pipe_length, 1],
    [can_wp + can_pr + wall, pipe_length, 1],
    [can_wp + wall + can_pr, 0, 1],
    [can_wp + can_pr, inner_slope_start_y + wall, 90],
    [inner_slope_start_x, inner_slope_start_y, 1],
    [inner_slope_start_x + ramp_edge_offset_x, inner_slope_start_y - ramp_edge_offset_y, 1],
    [
      inner_slope_start_x + ramp_edge_offset_x + ramp_edge_point_x,
      inner_slope_start_y - ramp_edge_offset_y + ramp_edge_point_y,
      1
    ],
    [0, inner_slope_start_y - ramp_edge_offset_y + ramp_edge_point_y, 20],
  ];

  inner_points = [
    [can_wp, pipe_length, 0],
    [can_wp, pipe_length, 0],
  ];

  linear_extrude(wall) {
    difference() {
      polygon(polyRound(points, 30));

      polygon(polyRound(inner_points, 30));
    }
  }
}

module finished_walls() {
  difference() {
    linear_extrude(holster_w) {
      union() {
        frame_walls();

        translate([can_wp + can_wp/2 + wall, can_wp, 0])
        cleat(wall * 3);
      }
    }

    hull() {
      translate([-40, -70, holster_w/2])
        rotate([90, 0, 0])
        cylinder(r=40, h=70, center=true);

      translate([-100, -70, holster_w/2])
        rotate([90, 0, 0])
        cylinder(r=40, h=70, center=true);
    }

    translate([can_pr-5, pipe_length/2 - can_pr/2, holster_w/2])
    rotate([90, 0, 90])
    linear_extrude(10)
    infill_diamonds(9, 6, s=wall);
  }
}

module finished_frame() {
  difference() {
    frame();

    translate([can_wp, can_w, -1])
    linear_extrude(10)
    infill_diamonds(4, 7, s=wall);
  }
}

finished_frame();
// finished_walls();
// frame_walls();
// translate([can_wp, 0, 0]) can();
