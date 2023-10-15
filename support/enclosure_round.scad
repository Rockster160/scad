include <vars.scad>

// rad is INSIDE size, not outside
module enclosure_round(rad, height, wall=wall_size("flimsy"), tol=tolerance("loose")) {
  difference() {
    cylinder(r=rad+wall, h=height+(wall*3)); // *3 for floor, ceiling, and rails

    translate([0, 0, wall])
    cylinder(r=rad, h=height+(wall*3));

    cutout_w = 10;
    translate([rad - wall*2, -cutout_w/2, height + (wall*2) + rerr])
    cube([wall*4, cutout_w, wall*2]);

    translate([0, 0, height-rerr+(wall*2)])
    lid_round(rad, wall=wall, tol=tol, size_offset=tol/2);
  }

  // Rails
  rotate_extrude()
  translate([-rad-rerr, height+(wall*2), 0])
  polygon([
    [0, -wall],
    [wall+rerr, 0],
    [0, 0]
  ]);
}

module lid_round(rad, wall=wall_size("flimsy"), tol=tolerance("loose"), size_offset=0) {
  lid_r = rad - tol + size_offset;
  lid_h = wall;
  cylinder(r=lid_r+rerr, h=wall);

  rotate_extrude()
  translate([-lid_r-rerr, 0, 0])
  polygon([
    [0, 0],
    [-tol, lid_h/2],
    [0, lid_h]
  ]);
}
