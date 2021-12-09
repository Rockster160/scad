include <support/linepath.scad>
include <support/in_to_mm.scad>
include <support/infill_diamonds.scad>
  // x = Number of diamonds towards X direction
  // y = Number of diamonds towards Y direction
  // w = Width of each diamond
  // h = Height of each diamond
  // s = Space/padding between diamonds

//    _
//    | \__ c
//  a |     \___
//    |_________\
//       b

depth = 20;
wall = 1.5;

a = in_to_mm(2 + 11/16);
c = in_to_mm(5 + 13/16);
b = sqrt(pow(c, 2) - pow(a, 2));

// echo(str("c = ", c));
// echo(str("a = ", a));
// echo(str("b = ", b));

C = 90;
A = asin(a/c);
B = asin(b/c);

// echo(str("C = ", C));
// echo(str("A = ", A));
// echo(str("B = ", B));

difference() {
  linear_extrude(depth)
  path([
    [0, 0],
    [b, 0],
    [b+5, 9],
    [b, 0],
    [b-5, 0],
    [0, a],
    [0, 0],
  ], wall);

  v_stack = 1;
  h_stack = 10;
  d_w = b/h_stack - wall*2;
  d_h = depth/v_stack - wall*2;

  translate([b/2 - 5, 2, depth/2])
  rotate([90, 0, 0])
  linear_extrude(4)
  infill_diamonds(x=h_stack, y=v_stack, w=d_w, h=d_h, s=wall);

  translate([-2, a/2, depth/2])
  rotate([90, 0, 90])
  linear_extrude(4)
  infill_diamonds(x=5, y=v_stack, w=d_w, h=d_h, s=wall);

  bridge_b = b-5;
  bridge_angle = atan(bridge_b/a);
  //   # translate([cos(A/2)*bridge_b/2 + wall*3 + 1, sin(C/2)*a/2 + wall*3 + 1, depth/2])
  translate([bridge_b/2 - 1, a/2 - 1, depth/2])
  rotate([90, 0, bridge_angle+90])
  linear_extrude(4)
  infill_diamonds(x=12, y=v_stack, w=d_w, h=d_h, s=wall);
}
