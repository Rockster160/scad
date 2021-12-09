use <support/in_to_mm.scad>
use <support/countersink.scad>

wall = 1;
base = 2;
can_w = in_to_mm(2.6);
can_h = in_to_mm(4.83); // 122.682
pd = 3;
rerr = 0.01;

difference() {
  cylinder(r=(can_w + pd + wall*2)/2, h=can_h/3);

  translate([0, 0, base]) {
    cylinder(r=(can_w + pd)/2, h=can_h/3);

    translate([0, 0, rerr])
    countersink(8,   3.5,  3.75,  31.5);
  }
}
