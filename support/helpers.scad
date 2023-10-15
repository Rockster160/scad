include <vars.scad>
include <funcs.scad>

module rgb(r, g, b, a=1) {
  color([r/255, g/255, b/255, a])
  children();
}

module walls(inner_cube, wall_w=1, sides=["walls", "floor", "ceil"], center=[0, 0, 0]) {
  // TODO: Respect "sides"
  outer_cube = [inner_cube.x+(wall_w*2), inner_cube.y+(wall_w*2), inner_cube.z+(wall_w*2)];
  translate([-(outer_cube.x*center.x), -(outer_cube.y*center.y), -(outer_cube.z*center.z)])
  difference() {
    box(outer_cube);

    translate([wall_w, wall_w, has(sides, "floor") ? wall : -wall_w])
    box([inner_cube.x, inner_cube.y, outer_cube.z+(wall_w*2)]);
  }
}
module outerWalls(outer_cube, wall_w=1, sides=["walls", "floor", "ceil"], center=[0, 0, 0]) {
  walls([outer_cube.x+(wall_w*2), outer_cube.y+(wall_w*2), outer_cube.z+(wall_w*2)], wall_w, sides, center);
}

module box(size=[1, 1, 1], center=[0, 0, 0]) {
  // Should be able to provide a single value for size and/or center to apply to all 3
  translate([-(size.x*center.x), -(size.y*center.y), -(size.z*center.z)]) cube(size);
}

module roundedbox(size=[1, 1, 1], center=[0, 0, 0], radius=1) {
  // Should be able to provide a single value for size and/or center to apply to all 3
  translate([-(size.x*center.x), -(size.y*center.y), -(size.z*center.z)]) roundedcube(size, radius=radius);
}
