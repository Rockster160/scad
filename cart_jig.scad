include <support/vars.scad>
include <support/linepath.scad>
include <support/arc.scad>

phone_width = 20;
wall = wall_size("weak");

small_r = 20/2;
big_r = 30/2;

h_offset = 15;
height = h_offset + big_r;
width = 90;


linear_extrude(40) {
  arc(small_r, wall, 180, align="outside");

  translate([width, h_offset, 0])
  arc(big_r, wall, 180, align="outside");

  path([
    [0, small_r, 0],
    [0, height, 0],
    [width, height, 0],
  ], wall/2);

//   Bottom Brace
  line([0, height/2, 0], [width/2, height, 0], wall/2);

//   Step
  line([width, height, 0], [width, height + 10, 0], wall/2);
  line([width, height + 10, 0], [width + 8, height - 3, 0], wall/2);

  line([0, height, 0], [0, height + 30, 0], wall/2);
  line([0, height + 30, 0], [width/2, height, 0], wall/2);
}
