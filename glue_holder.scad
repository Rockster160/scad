function in_to_mm(in) = in * 25.4;

wall = 2;
rerr = 0.01;

hdepth = in_to_mm(2.5);
hwidth = in_to_mm(1.5);
hole_size = 10;

difference() {
  cylinder(hdepth, hwidth*1.5, hwidth/2);

  translate([0, 0, wall])
  cylinder(r=hwidth/2, h=hdepth);

  translate([0, 0, -rerr])
  cylinder(r=hole_size, h=wall+rerr*2);
}
