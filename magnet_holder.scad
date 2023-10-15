include <support/enclosure_round.scad>

$fn=100;

t = 0.6;
dia = 48 + t;
h = 24.5 + t;
wall = 4;

rad = dia/2;
lid_w = rad + (wall/2);
rerr = 0.01;

full_r = rad + wall;

// # translate([0, 0, wall])
// cylinder(r=(dia-t)/2, h=h-t);

module bowl() {
  difference() {
    cylinder(r=full_r, h=h + (wall*2));

    translate([0, 0, wall])
    cylinder(r=rad, h=h + (wall*2));
  }
}


module disc() {
  difference() {
    cylinder(r1=full_r, r2=full_r, h=wall);

    translate([0, -full_r, -rerr])
    cube([full_r, full_r*2.5, full_r]);
  }
}

enclosure_round(full_r, h);

// difference() {
//   bowl();
//
//   translate([0, 0, h+wall]) {
//     disc();
//
//     cylinder(r1=lid_w, r2=rad, h=wall);
//   }
// }

// translate([-full_r*2, 0, 0]) {
//   difference() {
//     union() {
//       disc();
//
//       scale([1/lid_w * (lid_w-0.3), 1/lid_w * (lid_w-0.3), 1zc])
//       cylinder(r1=lid_w, r2=rad, h=wall);
//     }
//
//     translate([0, 0, 4])
//     scale([1, 0.5, 0.2])
//     sphere(r=25/2);
//   }
// }
