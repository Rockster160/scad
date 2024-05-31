include <support/vars.scad>

holder_top = 82; // 82.1
holder_bot = 77;
can = 57.7;
height = 69;

$fn = 100;

difference() {
  cylinder(height, holder_bot/2 - tolerance("loose"), holder_top/2 - tolerance("loose"), center=false);
  translate([0, 0, -rerr])
  cylinder(r=can/2 + tolerance("near"), h=height+rerr2, center=false);
}
