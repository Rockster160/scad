include <support/roundedcube.scad>

rerr = 0.01;

t = 0.2;
t2 = t*2;

card_w = 85 - 1;
card_d = 54 - 1;
card_h = 3.5;

key_w = 52.3 + t2;
key_d = 21.8 + t2;
key_h = 2.1;

tag_r = 27.5/2 + t2;
battery_r = 20/2 + t2;

justify_spacing = (card_d - battery_r*2 - tag_r*2)/3;

difference() {
  roundedcube([card_w, card_d, card_h], radius=1.5);

  translate([justify_spacing + tag_r, justify_spacing + tag_r, -1]) {
    cylinder(r=tag_r, h=5);

    translate([0, tag_r + justify_spacing + battery_r, 0])
    cylinder(r=battery_r, h=5);

    // Wire path
    translate([-2, 3, -rerr])
    cube([4, justify_spacing + tag_r, 5]);
  }

  translate([tag_r + battery_r + justify_spacing*2 + 1.5, card_d - key_d - justify_spacing*2, card_h - key_h])
  cube([key_w, key_d, key_h + rerr]);
}
