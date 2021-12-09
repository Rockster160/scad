difference() {
  cylinder(r=10, h=40);

  translate([0, 0, -0.5])
  cylinder(r=8, h=41);

  translate([-2, -10, -0.1])
  cube([4, 4, 35]);

  translate([-2, 7, 5.01])
  cube([4, 4, 35]);
}

translate([0, 0, 20])
# square(size=[30, 30], center=true);
