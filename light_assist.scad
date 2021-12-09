include <support/in_to_mm.scad>
include <support/roundedcube.scad>

t = 0.4;
wall = 4;
rerr = 0.01;

pull_dia = 8.2;
push_dia_out = 8.2;
push_dia_in = 3.7;
push_dist = 26;
push_offset = 2;

finger_width = 18;

length = in_to_mm(6);

module torus(inner_r, width_r, angle=360) {
  rotate_extrude(angle=angle) translate([inner_r, 0, 0]) circle(width_r);

  if (angle == 180) {
//     cos(ang) * d
//     sin(ang) * d
    translate([inner_r, 0, 0])
    sphere(width_r);

    translate([-inner_r, 0, 0])
    sphere(width_r);
  }
}

module tube(r, w, h) {
  difference() {
    cylinder(r=r + t + w, h=h);

    translate([0, 0, -rerr])
    cylinder(r=r + t, h=h + rerr*2);
  }
}

module half_tube(r, w, h) {
  d = r*2;
  difference() {
    tube(r, w, h);

    translate([-(d + w), 0, -rerr])
    cube([(d + w)*2, d*2, r + rerr*2]);
  }
}

module pull() {
  translate([0, wall/2 + 0, push_dia_in + wall/2 + 0.3 + push_offset])
  rotate([-90, 0, 0])
  torus(push_dia_in/2 + wall/2 + t, wall/2, 180);

  translate([0, wall/2 + push_dist, push_dia_out+0.3])
  rotate([-90, 0, 0])
  torus(push_dia_out/2 + wall/2 + t, wall/2, 180);

  translate([-wall/2, 0, 0])
  roundedcube([wall, length, wall]);

  translate([0, length - 3, finger_width/2 + wall + 0.4])
  rotate([0, 90, 0])
  torus(finger_width/2 + wall/2 + t, wall/2);
}

module push() {
  translate([0, 0, push_dia_out+0.3])
  rotate([-90, 0, 0])
  torus(push_dia_out/2 + wall/2 + t, wall/2, 180);

  translate([0, push_dist, push_dia_in + wall/2 + 0.3 + push_offset])
  rotate([-90, 0, 0])
  torus(push_dia_in/2 + wall/2 + t, wall/2, 180);

  translate([-wall/2, 0, 0])
  roundedcube([wall, length, wall]);

  translate([0, length - 3, finger_width/2 + wall + 0.4])
  rotate([0, 90, 0])
  torus(finger_width/2 + wall/2 + t, wall/2);
}

pull();
translate([10, 0, 0]) {

  push();
}



// torus(80, 20, 180);
