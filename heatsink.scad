difference() {
  cube([30, 40, 5]);

  translate([3, 3, -1]) cube([30, 3, 12]);
  translate([-3, 9, -1]) cube([30, 3, 12]);
  translate([3, 15, -1]) cube([30, 3, 12]);
  translate([-3, 21, -1]) cube([30, 3, 12]);
  translate([3, 27, -1]) cube([30, 3, 12]);
  translate([-3, 33, -1]) cube([30, 3, 12]);
}
