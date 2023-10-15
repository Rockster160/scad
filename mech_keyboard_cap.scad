include <support/vars.scad>
include <support/and_mirror.scad>
include <kailh_btn.scad>
include <support/enclosure_round.scad>

$fn = 100;

wall = wall_size("flimsy");
tol = tolerance("loose");

blue_actuation_space = 3;
mushroom_width = 42;
// 3.7

// kailh
// blue

btn_tol = tolerance("friction");


module kailh_cap() {
  depth = 3; // 3.3
//   % difference() {
//     kailh_btn();
//
//     translate([-kailh_btn_w/2, -kailh_btn_w/2, depth-btn_tol])
//     cube([kailh_btn_w, kailh_btn_w, kailh_btn_h]);
//   }

//   color("blue")
  difference() {
    cylinder(r=kailh_btn_inner/2 - btn_tol/2, h=depth);

    andMirror([1, 1, 0])
    translate([0, 0, depth/2])
    cube([kailh_btn_cross_w+btn_tol, kailh_btn_cross_d+btn_tol, depth+rerr], center=true);
  }
}

module outemu_cap() {
  ou_wall = 0.4;
  ou_out_w = 6.95;
  ou_out_d = 5.3;
  ou_out_h = 4;

  translate([0, 0, blue_actuation_space])
  difference() {
    translate([0, 0, ou_out_h/2])
    cube([ou_out_w-(ou_wall*2)-btn_tol, ou_out_d-(ou_wall*2)-btn_tol, ou_out_h], center=true);

    translate([0, 0, -rerr])
    andMirror([1, 1, 0])
    translate([0, 0, kailh_btn_h/2])
    cube([kailh_btn_cross_w+btn_tol, kailh_btn_cross_d+btn_tol, kailh_btn_h], center=true);
  }

  column_h = mushroom_width/2;
  intersection() {
    translate([0, 0, blue_actuation_space+ou_out_h-rerr])
    translate([0, 0, column_h/2])
    cube([ou_out_w-(ou_wall*2)-btn_tol, ou_out_d-(ou_wall*2)-btn_tol, column_h], center=true);

    sphere(r=mushroom_width/2);
  }

  difference() {
    sphere(r=mushroom_width/2);
    sphere(r=mushroom_width/2 - wall);

    translate([0, 0, -mushroom_width/2])
    cube([mushroom_width, mushroom_width, mushroom_width], center=true);
  }
}

// lid_round(10);
// translate([0, 0, wall_size("flimsy")-rerr])
// kailh_cap();
// outemu_cap();
