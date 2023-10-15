include <support/vars.scad>
// include <support/roundedcube.scad>
// include <support/helpers.scad>
// include <support/and_mirror.scad>
// include <support/funcs.scad>
include <support/enclosure.scad>
include <esp.scad>

doround = !$preview;

btn_count = 5;

internal_spacing = 1;
padding = 2;
btn_cutout = 14.4; // kailh_cutout
btn_size = 16; // Outer size of button
btn_offset = btn_size-btn_cutout;

led_w = 5.5;

box_d = [
  esp_w+wall*2,
  esp_d + (btn_size+padding)*btn_count + internal_spacing + wall,
  20,
];

// translate([0, esp_d-wall*2, 0])
// rotate([0, 0, 270])

charger_w = 11;
charger_h = 7;
module micro_cutout() {
  translate([-tol, -micro_d/2 - 2 - tol, tol])
  roundedcube([charger_w + tol*2, micro_d*2 + tol*2, charger_h + tol*2], radius=1, doround=doround);
}

rotate([0, 0, 90]) {
  union() {
    difference() {
      enclosure(box_d, doround=doround);

      translate([box_d.x/2 + wall - charger_w/2, 0, wall-tol])
      micro_cutout();

      translate([box_d.x/2 + wall, esp_d*0.75, 0])
      cylinder(r=5, h=10, center=true);
    }

    translate([tol, esp_d+wall+tol*2, wall])
    cube([box_d.x+wall*2 - tol*2, wall*2, esp_full_height]);

    translate([wall/2-tol*2, wall+wall/2, wall])
    cube([wall*2, esp_d+wall, esp_full_height]);

    translate([box_d.x-wall/2+tol*2, wall+wall/2, wall])
    cube([wall*2, esp_d+wall, esp_full_height]);
  }

  translate([-box_d.x - wall/2, wall, 0])
  difference() {
    lid(box_d);

    translate([box_d.x/2, esp_d/2, 0])
    cylinder(r=led_w/2, h=10, center=true);

    for (i=[0:btn_count-1]) {
      translate([box_d.x/2 - btn_size/2, esp_d + internal_spacing + ((btn_size+padding)*i), -tol]) {
        translate([btn_offset/2, btn_offset/2, 0])
        cube([btn_cutout, btn_cutout, wall*2]);
      }
    }
  }
}
