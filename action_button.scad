// TODO: Re-measure pullups wire since it's thicker than the others. Might need to lift the ESP off the ground

include <support/vars.scad>
include <support/helpers.scad>
include <support/in_to_mm.scad>
include <esp.scad>
// include <kailh_btn.scad>
include <outemu_btn.scad>
include <support/roundedcube.scad>
include <support/enclosure_round.scad>
include <mech_keyboard_cap.scad>
include <support/enclosure.scad>
include <btn_cap.scad>

wall = wall_size("flimsy");
tol = tolerance("loose");

diagonal = sqrt(pow(esp_d, 2) + pow(esp_w, 2));
// enc_h = esp_full_height + tol + kailh_offset; // 13.2
enc_h = 14;
enc_r = (diagonal + tol - 2)/2;

led_w = 5.5;

doround=true;

module micro_cutout(ext_w=0) {
  charger_w = 11;
  charger_h = 7;
  translate([-tol, -micro_d/2 - 2 - tol, 0])
  roundedcube([charger_w + tol*2 + ext_w, micro_d*2 + tol*2, charger_h + tol*2], radius=1, doround=doround);
}

module flippedboard() {
  rotate([0, 0, 90])
  translate([0, 0, wall]) {
    translate([0, 0, -esp_h+tol])
    rotate([0, 180, 0])
    esp(center=true);
  }
}

module internals() {
  rotate([0, 0, 90])
  translate([0, 0, wall]) {
    translate([0, 0, esp_full_height+kailh_offset+tol])
    kailh();

    translate([0, 0, micro_h])
    esp(center=true);
  }
}

module enc() {
  module rounded_chamfer(radius=1) {
    translate([0, 0, radius])
    rotate([180, 0, 0])
    rotate_extrude()
    translate([enc_r, 0, 0])
    difference() {
      square([radius+rerr2, radius+rerr2]);
      circle(radius+rerr2);
    }
  }

  difference() {
    enclosure_round(enc_r, enc_h);

    // Charger slot
    translate([enc_r-3, -1, wall+1])
    micro_cutout(5);

    // Pushout
    cylinder(r=4, h=10, center=true);

    // Bottom Chamfer
    rounded_chamfer(2);
    // Top Chamfer
    translate([0, 0, enc_h+wall*3])
    rotate([0, 180, 0])
    rounded_chamfer(2);

    wificutout = [
      15+4,
      12+4,
      3.1
    ];
    translate([-9.5-2, -8, -rerr+1])
    cube(wificutout);

    // LED cutouts
    for (i=[1:3]) {
      rotate([0, 0, i*90])
      translate([enc_r, 0, wall*1.2 + enc_h*0.75])
      rotate([0, 90, 0])
      cylinder(r=led_w/2, h=10, center=true);
    }
  }

  // Balance holds
  andMirror([0, 1, 0])
  translate([-enc_r/2, esp_w/2, wall/2])
  cube([enc_r, wall*2, esp_full_height]);
}

module act_btn_lid() {
  difference() {
    lid_round(enc_r);

    cube([kailh_cutout, kailh_cutout, 10], center=true);
  }
}

module withbattery() {
//   translate([0, 0, wall]) {
//     translate([wall + esp_w/2, -bat_d/2 + esp_d/2, 0]) {
//       espAndShield(center=true);
//     }
//     translate([-bat_w/2, 0, 0])
//     battery();
//
//     translate([0, 0, 22])
//     outemu();
//   }

  cont_w = esp_w+bat_w+wall;
  cont_d = bat_d+(wall*2);

  difference() {
    translate([-bat_w-wall, -bat_d/2-wall, 0])
    enclosure([cont_w, cont_d, 20], doround=doround, radius=1);

    translate([wall + esp_w/2, -bat_d/2 + esp_d/2, wall])
    espCutout(with_shield=true, center=true);

    translate([wall + esp_w/2, -bat_d/2 + esp_d/2, wall])
    cylinder(r=5, h=10, center=true);

    translate([-bat_w/2, -bat_d/2 + esp_d/2, wall])
    cylinder(r=5, h=10, center=true);
  }

  translate([0, -bat_d/2, 0])
  cube([wall, cont_d, bat_h+wall]);

  translate([0, -bat_d/2 + esp_d + tol, rerr])
  cube([esp_w+wall, wall, bat_h+wall]);

  translate([-bat_w-wall + cont_w + (wall*3), -bat_d/2-wall, 0]) {
    difference() {
      lid([cont_w, cont_d]);

      translate([cont_w/2, cont_d/2, 0])
      cube([kailh_cutout, kailh_cutout, 10], center=true);
    }
  }
}

$fn = $preview ? 30 : 100;
if ($preview) {
//   internals();
//   translate([0, 0, esp_wifi_h+1])
//   flippedboard();
}

enc();

translate([enc_r*2 + wall*2, 0, 0])
act_btn_lid();
//
// translate([enc_r + wall*2, enc_r*1.5 + wall*2, 0])
// ball_cap((enc_r*2)-10);

// withbattery();

// keycap();
