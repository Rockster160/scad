function in_to_mm(in) = in * 25.4;

hf = in_to_mm(1/2);
wall = 2;
rerr = 0.01;
rerr2 = rerr*2;

// translate([0, hf+wall + 1, 0])
// difference() {
//   cube([hf+wall, hf, hf+wall]);
//
//   translate([wall+rerr, -rerr, wall+rerr])
//   cube([hf+rerr2, hf+rerr2, hf+rerr2]);
//
//   translate([hf/2 + wall, (hf)/2, 0])
//   cylinder(r=2, h=10, center=true, $fn=100);
// }

offset = in_to_mm(2);
w = offset + wall;
d = hf + wall;
h = hf + wall;

mirror([1, 0, 0])
difference() {
  cube([w, d, h]);

  translate([wall+rerr, wall+rerr, wall+rerr])
  cube([w, d, h]);

  translate([w - hf/2, d - hf/2, 0])
  cylinder(r=2, h=10, center=true, $fn=100);

  rotate([90, 0, 0])
  translate([w - hf/2, d - hf/2, 0])
  cylinder(r=2, h=10, center=true, $fn=100);
}
