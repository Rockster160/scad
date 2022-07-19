include <support/vars.scad>
include <support/roundedcube.scad>

// Size is INSIDE size, not outsize
module enclosure(size, wall=wall_size("flimsy"), doround=true, tol=tolerance("loose"), radius=1) {
  module rail(rail_depth) {
    translate([-rerr, rail_depth, 0])
    rotate([90, 180, 0])
    linear_extrude(rail_depth)
    polygon([
      [0, 0],
      [0, wall],
      [-wall-rerr, 0]
    ]);
  }

  difference() {
    roundedcube([size.x+wall*2, size.y+wall*2, size.z+wall], radius=radius, doround=doround);

    translate([wall, wall, wall])
    roundedcube([size.x, size.y, size.z+wall], radius=radius, doround=doround);

    cutout_w = 10;
    translate([size.x/2 + wall - cutout_w/2, -radius, size.z + rerr])
    roundedcube([cutout_w, wall + radius*2, wall*2]);

    translate([wall + tol/4, wall + tol/4, size.z+rerr])
    lid(size, size_offset=tol, wall=wall, tol=tol);
  }

  translate([wall, wall/2, size.z])
  rail(size.y+wall);

  translate([size.x + wall, size.y+wall + wall/2, size.z])
  rotate([0, 0, 180])
  rail(size.y+wall);

  translate([size.x+wall + wall/2, wall, size.z])
  rotate([0, 0, 90])
  rail(size.x+wall);

  translate([wall/2, size.y + wall, size.z])
  rotate([0, 0, -90])
  rail(size.x+wall);
}

module lid(size, wall=wall_size("flimsy"), tol=tolerance("loose"), size_offset=0) {
  lid_w = size.x - tol/2 + size_offset;
  lid_d = size.y - tol/2 + size_offset;
  lid_h = wall;

  module rail_clip(rail_depth) {
    translate([rerr, 0, 0])
    rotate([90, 0, 180])
    linear_extrude(rail_depth)
    polygon([
      [0, 0],
      [tol, lid_h/2],
      [0, lid_h]
    ]);
  }

  cube([lid_w-tol, lid_d-tol, lid_h]);

  translate([0, 0, 0])
  rail_clip(lid_d-tol);

  translate([lid_w - tol, 0, lid_h])
  rotate([0, 180, 0])
  rail_clip(lid_d-tol);

  translate([lid_w-tol, 0, 0])
  rotate([0, 0, 90])
  rail_clip(lid_w-tol);

  translate([lid_w-tol, lid_d-tol, lid_h])
  rotate([0, 180, 90])
  rail_clip(lid_w-tol);
}


// enclosure([20, 40, 10], doround=true);
// translate([25, 0, 0])
// lid([20, 40, 10]);
