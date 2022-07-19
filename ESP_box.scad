include <support/vars.scad>
include <esp.scad>
include <enclosure.scad>
include <support/roundedcube.scad>

wall = wall_size("flimsy");
tol = tolerance("loose");

btn_slot = 16.1;
esp_space = 5;
button_float = 3;
button_offset = bat_h + but_h + but_pin_h + button_float;
led_w = 5.5;

enc_w = bat_w + tol;
enc_d = bat_d + esp_d + esp_space + tol;
enc_h = button_offset;

esp_wall_spacer = ((enc_w - esp_w) / 2)- tol;

doround=false;

module esp_spacer() {
  translate([-(esp_wall_spacer+wall)/2, wall/2, wall/2])
  roundedcube([esp_wall_spacer + wall, esp_d + 5, bat_h], radius=1, doround=doround);
}

module balancer() {
  translate([-enc_w/2 - wall/2, 0, wall-1])
  roundedcube([enc_w + wall, 3, micro_h-tol+1], radius=1, doround=doround);
}

module micro_cutout() {
  charger_w = 10;
  charger_h = 6;
  translate([-tol, -micro_d/2 - 2 - tol, -tol])
  roundedcube([charger_w + tol*2, micro_d*2 + tol*2, charger_h + tol*2], radius=1, doround=doround);
}

module box() {
  translate([-enc_w/2, -bat_d - tol, 0]) {
    difference() {
      rotate([0, 0, 180])
      translate([-enc_w-wall, -enc_d-wall, 0])
      enclosure([enc_w, enc_d, enc_h], doround=doround);

      translate([enc_w/2, enc_d, 0]) {
        // Hard coded numbers
        translate([-esp_micro_x-1.2, 0, 10.6 - 2])
        micro_cutout();

        translate([-micro_w/2 - 0.6, 0, wall - 1])
        micro_cutout();

        // LED cutout
        translate([0, 0, 22])
        rotate([90, 0, 0])
        cylinder(r=led_w/2, h=10, center=true);

        // ESP push out
        translate([0, -esp_d + led_w/2 - wall/2, 0])
        cylinder(r=led_w/2, h=10, center=true);

        // Battery push out
        translate([0, -esp_d - 10, 0])
        cylinder(r=led_w/2, h=10, center=true);
      }
    }
  }

  translate([0, esp_d - micro_d, 0])
  balancer();

  translate([0, esp_space * 2, 0])
  balancer();

  translate([enc_w/2 - esp_wall_spacer/2 + wall/2 - rerr, 0, 0])
  esp_spacer();

  translate([-enc_w/2 + esp_wall_spacer/2 - wall/2 + rerr, 0, 0])
  esp_spacer();

  translate([-enc_w/2 - wall/2, tol, wall/2])
  roundedcube([enc_w + wall, esp_space - tol*2, bat_h], radius=1, doround=doround);
}

module internals() {
  translate([0, 0, wall]) {
    translate([0, esp_d/2 + esp_space, 0])
    rotate([0, 0, 180])
    fullESP(center=true);

    translate([0, -bat_d - tol + enc_d - enc_w/2, button_offset])
    button();

    translate([0, -bat_d/2, 0])
    battery();
  }
}

box();
translate([enc_w/2 + wall*2, -bat_d - tol, 0]) {
  difference() {
    lid([enc_w, enc_d, enc_h]);

    translate([enc_w/2, enc_d - enc_w/2, 0])
    cylinder(r=btn_slot/2, h=10, center=true);
  }
}
internals();
