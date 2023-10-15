include <vars.scad>
include <roundedcube.scad>

// Size is INSIDE size, not outsize -- Does NOT include rails, so an object of `size` will NOT fit
// Must add `size + enc_wall*2` in order to get object to fit
module enclosure(size, enc_wall=wall_size("flimsy"), tol=tolerance("loose"), doround=true, radius=1) {
  module rail(rail_depth) {
    translate([-rerr, rail_depth, 0])
    rotate([90, 180, 0])
    linear_extrude(rail_depth)
    polygon([
      [0, 0],
      [0, enc_wall],
      [-enc_wall-rerr, 0]
    ]);
  }

  difference() {
    roundedcube([size.x+enc_wall*2, size.y+enc_wall*2, size.z+enc_wall], radius=radius, doround=doround);

    translate([enc_wall, enc_wall, enc_wall])
    roundedcube([size.x, size.y, size.z+enc_wall], radius=radius, doround=doround);

    cutout_w = 15;
    translate([size.x/2 + enc_wall - cutout_w/2, -radius, size.z + rerr])
    roundedcube([cutout_w, enc_wall + radius*2, enc_wall*2]);

    translate([enc_wall + tol/4, enc_wall + tol/4, size.z+rerr])
    lid(size, enc_wall=enc_wall, tol=tol, size_offset=tol);
  }

  translate([enc_wall, enc_wall/2, size.z])
  rail(size.y+enc_wall);

  translate([size.x + enc_wall, size.y+enc_wall + enc_wall/2, size.z])
  rotate([0, 0, 180])
  rail(size.y+enc_wall);

  translate([size.x+enc_wall + enc_wall/2, enc_wall, size.z])
  rotate([0, 0, 90])
  rail(size.x+enc_wall);

  translate([enc_wall/2, size.y + enc_wall, size.z])
  rotate([0, 0, -90])
  rail(size.x+enc_wall);
}

module lid(size, enc_wall=wall_size("flimsy"), tol=tolerance("loose"), size_offset=0) {
  lid_w = size.x - tol/2 + size_offset;
  lid_d = size.y - tol/2 + size_offset;
  lid_h = enc_wall;

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
