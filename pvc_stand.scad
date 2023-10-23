include <support/vars.scad>
// include <support/arc_rad_from_wh.scad>
include <support/in_to_mm.scad>


// cir = in_to_mm(1.5);

cir = 42 + tolerance("friction");
rad = cir;
wall = wall_size("solid"); // 6

function tri_height(side) = (sqrt(3) / 2) * side;
function circumcenter(side) = (sqrt(3) / 3) * side;
function triside_wrap_circle(rad) = 2 * (rad * sqrt(3));

rad_walls = rad + wall;
triangle_side = triside_wrap_circle(rad_walls);
triangle_height = tri_height(triangle_side);

module triangle(side) {
  height = tri_height(side);
  rotate([0, 0, 180])
  translate([0, -circumcenter(side), 0])
  polygon([
      [side / 2, height],
      [-side / 2, height],
      [0, 0]
  ]);
}

module round(inner_rad, triside=triangle_side) {
  triheight = tri_height(triside);
  cmc = circumcenter(triside);
  difference() {
    triangle(triside+rerr2);

    translate([0, cmc - inner_rad*2 - rerr, 0]) {
      circle(inner_rad+rerr);

      translate([-triside/2, -triside - inner_rad + tri_height(triside_wrap_circle(inner_rad))/2, 0])
      square(triside+rerr2);
    }
  }
}

module pvcstand_flat() {
  difference() {
    triangle(triangle_side);

    circle(rad);

    round(rad_walls);

    rotate([0, 0, 120])
    round(8);
    rotate([0, 0, -120])
    round(8);
  }
}

linear_extrude(50)
pvcstand_flat();
