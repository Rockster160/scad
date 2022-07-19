include <support/vars.scad>
use <support/in_to_mm.scad>
use <support/countersink.scad>
use <support/roundedcube.scad>
use <support/centeredcube.scad>
use <support/arc.scad>

tolerance = tolerance("near");;
wall = wall_size("stronger");

bar = in_to_mm(0.5) + tolerance*2 - 0.1;
max_distance = in_to_mm(4);
opening = 70; // Clearance for pipes to miss drill
stable_height = in_to_mm(2);
tool_bracket_h = max_distance - stable_height;

base_w = (wall + bar + wall)*2 + opening;

tool_dia = 64.5 + tolerance;
top_l = 43.4 + 0.2;
side_l = 32.9 + 0.2;

bot_gap = 82;
// https://www.handymath.com/cgi-bin/arc18.cgi?submit=Entry
// arc(inner_r, wall, angle, align="inside");

module pipe(r, h) {
  difference() {
    cylinder(r=r+wall, h=h);

    translate([0, 0, -rerr])
    cylinder(r=r, h=h+rerr*2);
  }
}

module floor_bracket() {
  difference() {
    centeredcube([base_w, base_w, wall]);

    translate([0, 0, -rerr])
    cylinder(r=opening/2, h=wall+rerr*2);
  }

  translate([base_w/2 - bar/2 - wall, 0, 0])
  pipe(bar/2, stable_height);

  translate([-base_w/2 + bar/2 + wall, 0, 0])
  pipe(bar/2, stable_height);

  translate([0, base_w/2 - bar/2 - wall, 0])
  pipe(bar/2, stable_height);
}

module tool_bracket() {
  $fn = 100;
  linear_extrude(wall) {
    difference() {
      rotate([0, 0, -90+bot_gap/2])
      arc(tool_dia/2 + wall, wall+bar+wall, 360-bot_gap, align="inside");

      // Arc calc fix
      translate([-25, -tool_dia, 0])
      square([50, 10]);

      translate([base_w/2 - bar/2 - wall, 0, 0])
      circle(r=bar/2);
      translate([-base_w/2 + bar/2 + wall, 0, 0])
      circle(r=bar/2);
      translate([0, base_w/2 - bar/2 - wall, 0])
      circle(r=bar/2);
    }

    difference() {
      teeth_r = tool_dia/2 - wall;

      rotate([0, 0, -90+bot_gap/2])
      arc(teeth_r+2, wall*2, 360-bot_gap, align="inside");

      top_ang = 85;
      rotate([0, 0, 90 - top_ang/2])
      arc(teeth_r-1, wall+2, top_ang);

      side_ang = 64;
      rotate([0, 0, -side_ang/2 - 3])
      arc(teeth_r-1, wall+2, side_ang);

      rotate([0, 0, 180-side_ang/2 + 3])
      arc(teeth_r-1, wall+2, side_ang);
    }
  }

//   # cylinder(r=tool_dia/2, h=1);

  translate([base_w/2 - bar/2 - wall, 0, 0])
  pipe(bar/2, tool_bracket_h);

  translate([-base_w/2 + bar/2 + wall, 0, 0])
  pipe(bar/2, tool_bracket_h);

  translate([0, base_w/2 - bar/2 - wall, 0])
  pipe(bar/2, tool_bracket_h);
}

// difference() {
//   tool_bracket();
//
//   translate([-max_distance, -max_distance, 2])
//   cube([max_distance*2, max_distance*2, max_distance*2]);
// }
// tool_bracket();
floor_bracket();
