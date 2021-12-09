$fn = 100;

include <support/in_to_mm.scad>

wall = 1;
rerr = 0.01;
offset = 0.5;

size = 1/2;

w = in_to_mm(size);



difference() {
  union() {

    difference() {
      cube([w+wall, w+wall, wall]);

      translate([0, 0, -rerr/2])
      cylinder(r=w, h=wall+rerr);
    }
    translate([w, 0, 0])
    cube([wall, w+wall, wall*3]);

    translate([0, w, 0])
    cube([w+wall, wall, wall*3]);
  }

  translate([w+wall - 0.8, (w+wall)/2, 0.5])
  rotate([90, 0, 90])
  linear_extrude(2)
  text("1/2", size=(wall*3)-1, halign="center");
}
