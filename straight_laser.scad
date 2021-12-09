$fn = 100;

laser_w = 5.75;
laser_h = 10;
laser_o = 3.4;
t = 0.4;
wall = 3;
rerr = 0.01;

stand_h = 100;
stand_w = 100;

module laser_holder() {
  difference() {
    cylinder(r=laser_w/2 + t + wall, h=laser_h + t*2);

    translate([0, 0, -rerr]) {
      cylinder(r=laser_w/2 + t, h=laser_h + t*2 + rerr*2);
    }
  }

  rotate([180, 0, 0])
  rotate_extrude()
  translate([-(laser_w/2 + t + rerr), -(laser_h - laser_o - t + 0.25), 0])
  scale(t/2) polygon([[0, 0], [0, 1], [1, 0]]);
}

module stand() {
  steps = 5;

  difference() {
    cylinder(r=stand_w/2, h=wall);

    translate([0, 0, -rerr])
    cylinder(r=stand_w/2 - wall, h=wall + rerr*2);
  }

  translate([0, 0, stand_h - 20]) {
    difference() {
      cylinder(20, 14.87, laser_w/2 + wall + t);

      translate([0, 0, -rerr])
      cylinder(20+rerr*2, 14.87 - wall, laser_w/2 + t);

      for (i=[0:360/steps:360]) {
        rotate([0, 0, i+5])
        translate([-10, 0, 0])
        rotate([0, 90, 0])
        cylinder(r=7.5, h=10, center=true);
      }
    }
  }

  difference() {
    for (i=[0:360/steps:360]) {
      rotate([0, 0, i])
      rotate_extrude(angle=10)
      polygon([
        [stand_w/2, 0],
        [stand_w/2-wall, 0],
        [(laser_w/2 + t), stand_h],
        [(laser_w/2 + t + wall), stand_h],
      ]);

      rotate([0, 0, i])
      translate([-stand_w/2 + wall/2, -5, 0])
      cube([stand_w/2, 10, wall]);
    }
    cylinder(r=5, h=10, center=true);  
  }
}

stand();

translate([0, 0, stand_h])
laser_holder();
