include <support/vars.scad>
include <support/in_to_mm.scad>

extra_spacing = 1;
cup_holder_width = in_to_mm(2 + 15/16); // +2/16
cup_holder_depth = in_to_mm(2);
flask_width = 90.5 + tolerance("loose") + extra_spacing;
flask_height = in_to_mm(8.5);

wall_depth = flask_height/4;
wall = wall_size("stronger");

$fn = $preview ? 30 : 100;

// cylinder(r=cup_holder_width/2, h=cup_holder_depth);
//
// translate([0, 0, cup_holder_depth-rerr])
// difference() {
//   cylinder(r=flask_width/2 + wall, h=wall_depth);
//   translate([0, 0, wall])
//   cylinder(r=flask_width/2, h=wall_depth);
// }

// translate([0, flask_width/2, flask_height/5 + cup_holder_depth]) {
//   cube(size=[wall, wall, wall]);
// }

// holder_top = 82; // 82.1
// holder_bot = 77;
// can = 57.7;
// height = 69;
//
// $fn = 100;
//
// difference() {
//   cylinder(height, holder_bot/2 - tolerance("loose"), holder_top/2 - tolerance("loose"), center=false);
//   translate([0, 0, -rerr])
//   cylinder(r=can/2 + tolerance("near"), h=height+rerr2, center=false);
// }


// # cylinder(r=flask_width/2 + wall, h=wall_depth);
union() {
  max_bigger=15/2; // n/2 because measured by pushing against a wall and pushing in finger, so only got 1 side
  original = (cup_holder_width/2 + wall)+tolerance("friction");

  difference() {
    cylinder(r1=original+max_bigger, r2=original+max_bigger-wall, h=wall_depth-rerr);
    translate([0, 0, -rerr2])
    cylinder(r=original, h=wall_depth+rerr2);
  }

  // translate([0, 0, wall_depth])
  // cube([max_bigger, max_bigger, max_bigger]);
}
