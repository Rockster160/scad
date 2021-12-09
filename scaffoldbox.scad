use <support/in_to_mm.scad>

rerr = 0.01;

centers = in_to_mm(19 + 7/8);
height = in_to_mm(3);
hole = in_to_mm(1);

wall = in_to_mm(0.5);

w = in_to_mm(5) + hole + (wall*3);
d = centers + hole + wall*2;
h = height;

module plate() {
  difference() {
    cube([w, d, wall]);

    translate([0, 0, -rerr]) {
      translate([wall + hole/2, wall + hole/2, 0]) cylinder(r=hole/2, h=wall+rerr*2);
      translate([wall + hole/2, d-(wall + hole/2), 0]) cylinder(r=hole/2, h=wall+rerr*2);
    }
  }
}

module driver() {
  driver_w = in_to_mm(4);
  driver_d = in_to_mm(12);
  driver_h = in_to_mm(6);
  driver_bit = in_to_mm(1);

  # cube([driver_w, driver_d, driver_h]);
  color("blue") {
    translate([driver_w/2, driver_d, 0])
    cylinder(r=driver_bit/2, h=100, center=true);
  }
}

translate([wall*2 + hole, 0, 0]) 
driver();

difference() {
  plate();

  hull() {

  }
}
