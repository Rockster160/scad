include <support/linepath.scad>
include <support/in_to_mm.scad>
include <support/polyround.scad>

$fn = 100;

od = in_to_mm(0.5);
id = 5;
plate = 0;
depth = in_to_mm(2);
wall = 1;

offset = id/2 + wall/2;

points = [
  [offset + 2, 0, 0],
  [offset, 2, 5],
  [offset, depth-10, 0],
  [offset, depth + wall, 6],
  [offset + od + plate, depth + wall, 0],
];

rotate([180, 0, 0])
rotate_extrude()
path(polyRound(points));

// # cylinder(r=od/2, h=depth);

// difference() {
  // path(polyRound(points));
  //
  // diff_height = 10;
  // translate([od/2, depth - diff_height, 0])
  // # square([20, diff_height]);
// }
