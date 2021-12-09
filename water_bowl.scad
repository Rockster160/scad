include <support/in_to_mm.scad>

tolerance = 0.8;
w = in_to_mm(3 + (3/8));
rw = w/2;
wall = 2;
h = 34;
rh = 30;
bw = 51;

module bowl() {
  translate([0, 0, h - rh])
  cylinder(r=w/2 + tolerance, h=rh+wall);
  cylinder(r=bw/2 + tolerance, h=h);
}


difference() {
  cylinder(r1=rw*1.5, r2=rw, h=h + wall + tolerance);

  translate([0, 0, wall])
  bowl();
}
