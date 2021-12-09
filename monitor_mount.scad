// Next time: Print on it's side!

use <support/in_to_mm.scad>
use <support/countersink.scad>
use <support/roundedcube.scad>
use <support/centeredcube.scad>

tolerance = 0.5;
monitor_width = 35 + tolerance;
monitor_distance = 18;
wall = 7;
spacer = wall*4;
rerr = 0.01;

width = 50;
height = 25;
depth = monitor_distance + monitor_width + wall;

module mount() {
  difference() {
    roundedcube([width, depth, height], radius=1);

    translate([-rerr, monitor_distance, wall])
    cube([width+rerr*2, monitor_width, height]);

    translate([wall*2, depth-wall-rerr, wall])
    cube([width - spacer, wall+rerr*2, height]);

     translate([width/2, monitor_distance-8, height])
    rotate([-35, 0, 0])
    translate([0, 0, -3])
    countersink(8.5, 4.75, 4.25,  64.75, 15);
  }
}

module bracket() {
  translate([0, 0, 1])
  rotate([0, 90, 0])
  linear_extrude(wall)
  scale(monitor_width)
  polygon([[0,0],[1,0],[0,1]]);
}

rotate([0, -90, 0]) {
  mount();
  bracket();

  translate([width - wall, 0, 0])
  bracket();
}
