module moon(d, h) {
  difference() {
    r = d/2;
    outer = r+5;
    t = 1;
    cylinder(r=outer, h=h);

    translate([0, 0, -t/2])
    cylinder(r=r, h=h+t);

    translate([-outer, 0, -t/2])
    cube([outer*2 + t*2, outer + t, h+t]);
  }
}


moon(35, 5);

translate([0, -66, 38])
rotate([55, 0, 0])
moon(25, 5);

translate([-2.5, -80, 0])
cube([5, 60, 5]);

translate([-2.5, -80, 0])
cube([5, 5, 27]);
