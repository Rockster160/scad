include <support/vars.scad>
include <support/and_mirror.scad>

kailh_offset = 5.5; // Bottom to flush

kailh_btn_w = 6.5;
kailh_btn_h = 6.4;
kailh_btn_inner = 5.5;
kailh_btn_cross_w = 4;
kailh_btn_cross_d = 1.3;

kailh_over_base = 3.1;
kailh_under_base = 2.2;

kailh_w = 15;
kailh_cutout = 14.4;

kailh_full_h = kailh_offset + kailh_btn_h;

module kailh_btn() {
  translate([0, 0, kailh_btn_h/2])
  difference() {
    cylinder(r=kailh_btn_w/2, h=kailh_btn_h, center=true);
    cylinder(r=kailh_btn_inner/2, h=kailh_btn_h+rerr, center=true);
  }
  andMirror([1, 1, 0])
  translate([0, 0, kailh_btn_h/2])
  cube([kailh_btn_cross_w, kailh_btn_cross_d, kailh_btn_h], center=true);
}

module kailh() {
  // Btn
  color("red") {
    kailh_btn();
  }

  // Base
  // -- Top/Over
  color("silver", 0.9)
  translate([0, 0, kailh_over_base/2])
  cube([kailh_w, kailh_w, kailh_over_base], center=true);
  // -- Bottom/Under
  rgb(50, 50, 50)
  translate([0, 0, -kailh_under_base/2+rerr])
  cube([kailh_cutout, kailh_cutout, kailh_under_base+rerr*2], center=true);
  // -- Bottom- dot thing?
  rgb(50, 50, 50)
  translate([0, 0, -kailh_offset/2])
  cylinder(r=4.8/2, h=kailh_offset, center=true);

  // Pins
  translate([0, 0, -3 - kailh_under_base]) {
    color("gold")
    translate([0, 5.9, 0])
    cube([0.8, 0.3, 3]);

    color("silver")
    translate([3.8, 5, 0])
    cube([0.8, 0.3, 3]);

    color("silver")
    translate([-5.15, -5, 0])
    cube([0.8, 0.3, 3]);
  }
}
