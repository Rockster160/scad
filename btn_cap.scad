include <support/vars.scad>
include <support/roundedcube.scad>
include <support/helpers.scad>
// include <support/and_mirror.scad>
include <support/funcs.scad>
include <outemu_btn.scad>

$fn = $preview ? 30 : 100;
wall = wall_size("paper");

btn_size = dist([outemu_w, outemu_w, outemu_over_base]) + 2.5;

module ball_cap(inner_dia) {
  difference() {
    sphere(r=(inner_dia/2) + wall);

    sphere(r=inner_dia/2);

    translate([0, 0, -inner_dia])
    cube([inner_dia*2, inner_dia*2, inner_dia*2], center=true);
  }

  outemu_connector(5);
  intersection() {
    sphere(r=(inner_dia/2) + wall);
    outemu_connector(10);
  }
}

module keycap() {
//   translate([0, 0, -outemu_over_base])
//   outemu();

  box_width = 15;

  height = blue_actuation_space + ou_out_h + 2;
  outemu_connector(1);
  difference() {
    roundedbox([box_width+wall, box_width+wall, height], center=[0.5, 0.5, 0]);

    translate([0, 0, -tol])
    roundedbox([box_width, box_width, height-wall], center=[0.5, 0.5, 0]);
  }
}

// ball_cap(btn_size);

// outemu_w
//
// outemu_offset = 5.5; // Bottom to flush
//
// ou_wall = 0.4;
// ou_out_w = 6.95;
// ou_out_d = 5.3;
// ou_out_h = 4;
//
// outemu_btn_w = 6.5;
// outemu_btn_h = 6.4;
// outemu_btn_inner = 5.5;
// outemu_btn_cross_w = 4;
// outemu_btn_cross_d = 1.3;
//
// outemu_over_base = 6.1;
// outemu_under_base = 7.1;
//
// outemu_w = 15;
// outemu_cutout = 14.4;
//
// outemu_full_h = outemu_offset + outemu_btn_h;
//
// module outemu_btn() {
//   walls([ou_out_w, ou_out_d, ou_out_h], ou_wall, center=[0.5, 0.5, 0]);
//
//   andMirror([1, 1, 0])
//   box([outemu_btn_cross_w, outemu_btn_cross_d, ou_out_h], center=[0.5, 0.5, 0]);
// }
//
// module outemu() {
//   // Btn
//   color("#0160FF") {
//     translate([0, 0, outemu_over_base])
//     outemu_btn();
//   }
//
//   // Base
//   // -- Top/Over
//   color("silver", 0.9)
//   translate([0, 0, outemu_over_base/2])
//   cube([outemu_w, outemu_w, outemu_over_base], center=true);
//   // -- Bottom/Under
//   rgb(50, 50, 50)
//   translate([0, 0, -outemu_under_base/2+rerr])
//   cube([outemu_cutout, outemu_cutout, outemu_under_base+rerr*2], center=true);
//   // -- Bottom- dot thing?
//   rgb(50, 50, 50)
//   translate([0, 0, -outemu_offset/2])
//   cylinder(r=4.8/2, h=outemu_offset, center=true);
//
//   // Pins
//   translate([0, 0, -3 - outemu_under_base]) {
//     color("gold")
//     translate([0, 5.9, 0])
//     cube([0.8, 0.3, 3]);
//
//     color("silver")
//     translate([3.8, 5, 0])
//     cube([0.8, 0.3, 3]);
//
//     color("silver")
//     translate([-5.15, -5, 0])
//     cube([0.8, 0.3, 3]);
//   }
// }
//
