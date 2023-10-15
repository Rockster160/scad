include <support/vars.scad>
include <support/helpers.scad>

esp_d = 34.7;
esp_w = 25.9;
esp_h = 1.25; // Only the board
// esp_full_height is defined below

micro_d = 5.6;
micro_w = 7.7;
micro_h = 2.8;
esp_micro_x = 8.75;
shield_micro_x = 14.25;

esp_wifi_h = 4.4 - esp_h;
esp_wifi_d = 15.1;
esp_wifi_w = 11.85;
esp_wifi_x = 6.5;
esp_wifi_y = 11.85;

shield_w = 26;
shield_d = 28;
shield_h = 1.5;

shield_power_x = 4.6;
shield_power_w = 7.5;
shield_power_d = 7;
shield_power_h = 7.6 - shield_h;

board_spacer_h = 2.5;
board_spacer_w = 2.5;
board_spacer_d = 19.85;

bat_w = 33.7;
bat_d = 50;
bat_h = 10;

but_h = 13;
but_pin_h = 5.5;

text_size = 0.85;

relay_d = 70.18;
relay_w = 17.1;
relay_h = 1.4;
relay_blue_box_h = 16.95 - relay_h;
relay_blue_box_d = 18.94;
relay_blue_box_w = 15.14;
relay_blue_box_y = 34.4;
relay_outlet_w = 15.23;
relay_outlet_d = 10.3;
relay_outlet_h = 15.83 - relay_h;
relay_outlet_y = 4.5;
wire_bridge_w = 2.45;
wire_bridge_spacing = 14.35 - (wire_bridge_w*2);
wire_bridge_d = 5;
wire_bridge_h = 10.5 - relay_h;
wire_bridge_y = 21.5;
relay_wire_connector_spacing = 2;
relay_wire_connector_w = 2.15;

esp_full_height = micro_h + esp_h + esp_wifi_h;

module txt(txt_str) {
  color("white")
  rotate([0, 0, 90])
  text(txt_str, size=text_size, halign="center");
}
module etxt(txt_str) {
  translate([text_size, 0, 0]) {
    rotate([0, 180, 0])
    txt(txt_str);

    translate([0, 0, esp_h])
    txt(txt_str);
  }
}

module slot(label) {
  translate([1.75, 0, shield_h/2])
  color("silver")
  cylinder(r=1.75/2, h=shield_h+rerr*2, center=true, $fn=10);

  translate([3.6, 0, 0])
  etxt(label);
}

module antenna() {
  color("gold") {
    difference() {
      ww = 0.75;
      sp = 2;
      cube([16, 7, 0.1]);

      translate([ww, -ww, -0.05])
      cube([1.5, 7, 0.2]);

      offset = ww*2 + 1.5;
      translate([offset, -ww, -0.05])
      cube([1.5, 7, 0.2]);

      translate([offset, -ww, -0.05])
      cube([12, 3, 0.2]);

      translate([offset+1.5 + ww, 7-4, -0.05])
      cube([2, 7, 0.2]);

      translate([offset+1.5 + ww*2 + sp, -ww, -0.05])
      cube([2, 7, 0.2]);

      translate([offset+1.5 + ww*3 + sp*2, 7-4, -0.05])
      cube([2, 7, 0.2]);

      translate([offset+1.5 + ww*4 + sp*3, -ww, -0.05])
      cube([2, 7, 0.2]);
    }
  }
}

module esp(center=false) {
  offset_x = center ? -esp_w/2 : 0;
  offset_y = center ? -esp_d/2 : 0;
  translate([offset_x, offset_y, 0]) {
    // Board
    difference() {
      rgb(28, 85, 140)
      cube([esp_w, esp_d, esp_h]);

      translate([-rerr, -rerr, -rerr])
      cube([2, 7, esp_h+(rerr*2)]);
    }

    // Micro USB Port
    translate([esp_micro_x, 0, -micro_h])
    color("silver")
    cube([micro_w, micro_d, micro_h]);

    // Wifi IC Chip/board
    translate([esp_wifi_x, esp_wifi_y, esp_h])
    color("silver")
    cube([esp_wifi_w, esp_wifi_d, esp_wifi_h]);

    translate([5, esp_d-7-rerr, esp_h+rerr])
    antenna();

    translate([0, 9, 0])
    slot("3v3");

    translate([0, esp_d-7.5, 0])
    slot("RST");

    translate([esp_w, 9, 0])
    rotate([0, 0, 180])
    slot("5v");

    translate([esp_w, esp_d-7.5, 0])
    rotate([0, 0, 180])
    slot("TX");
  }
}

module shield() {
  difference() {
    rgb(28, 85, 140)
    cube([shield_w, shield_d, shield_h]);

    translate([-rerr, -rerr, -rerr])
    cube([2, 7, shield_h+(rerr*2)]);
  }

  color("tan")
  translate([shield_power_x, 0, shield_h])
  cube([shield_power_w, shield_power_d, shield_power_h]);

  color("silver")
  translate([shield_micro_x, 0, shield_h])
  cube([micro_w, micro_d, micro_h]);

  translate([0, 9, 0])
  slot("3v3");

  translate([0, esp_d-7.5, 0])
  slot("RST");

  translate([esp_w, 9, 0])
  rotate([0, 0, 180])
  slot("5v");

  translate([esp_w, esp_d-7.5, 0])
  rotate([0, 0, 180])
  slot("TX");
}

module espAndShield(center=false) {
  offset_x = center ? -esp_w/2 : 0;
  offset_y = center ? -esp_d/2 : 0;
  translate([offset_x, offset_y, micro_h]) {
    esp();

    color("black", 0.6)
    translate([0.5, 7.9, esp_h+0.3])
    cube([board_spacer_w, board_spacer_d, board_spacer_h]);

    color("black", 0.6)
    translate([esp_w - 0.5 - board_spacer_w, 7.9, esp_h+0.3])
    cube([board_spacer_w, board_spacer_d, board_spacer_h]);

    translate([0, 0, esp_h+0.6 + board_spacer_h])
    shield();
  }
}

module button() {
  color("black", 0.9) {
    translate([0, 0, -13])
    cylinder(r=15.5/2, h=but_h);

    cylinder(1.75, 18.5/2, 16/2);
  }
  color("red", 0.9)
  cylinder(r=12.9/2, h=4);

  translate([-3/2, -0.6/2, -but_pin_h - but_h])
  color("silver", 0.9) {
    translate([0, 9/2 - 0.6, 0])
    cube([3, 0.6, but_pin_h]);

    translate([0, -9/2, 0])
    cube([3, 0.6, but_pin_h]);
  }
}

module espWalls() {
  difference() {
    walls([esp_w, esp_d, esp_full_height]);

    espWallsCutout();
  }
}
module espWallsCutout() {
  translate([1, 0, 0]) {
    wificutout = [
      12+4,
      15+4,
      3.1
    ];
    translate([-7.2-2, 12.3-2, -rerr+1])
    translate([esp_w/2 + wall, 0, 0]) {
      cube(wificutout);
      translate([2.5, 2.5, -2])
      cube([wificutout[0]-5, wificutout[1]-5, wificutout[2]]);
    }
    charger_w = 10;
    charger_h = 8;
    translate([13.3 - charger_w/2, -rerr, wall+1.5])
    #cube([charger_w, wall*2, charger_h]);
  }
}

module espCutout(with_shield=true, center=false) {
  charger_w = 10;
  charger_h = 6;
  cutout_depth = 10;

  module cutout() {
    offset_x = center ? -esp_w/2 : 0;
    offset_y = center ? -esp_d/2 : 0;
    translate([0, -cutout_depth, 0])
    translate([offset_x, offset_y, 0])
    cube([charger_w + tol*2, cutout_depth+micro_d, charger_h + tol*2]);
  }

  translate([esp_micro_x + micro_w/2 - (charger_w + tol*2)/2, 0, -micro_h/2])
  cutout();

  if (with_shield) {
    cut_h = esp_full_height;
    translate([shield_micro_x + micro_w/2 - (charger_w + tol*2)/2, 0, cut_h])
    cutout();
  }
}

module battery() {
  color("brown", 0.8)
  translate([-bat_w/2, -bat_d/2, 0])
  cube([bat_w, bat_d, bat_h]);
}

module relay() {
  // Board
  difference() {
    blue_black = [0/255, 0/255, 47/255];
    color(blue_black)
    cube([relay_w, relay_d, relay_h]);

    hole_r = 2.1/2;
    hole_offset = 0.6;

    translate([hole_offset + hole_r, hole_offset + hole_r, relay_h/2])
    cylinder(r=hole_r, h=relay_h*2, center=true, $fn=20);

    translate([relay_w - hole_r - hole_offset, hole_offset + hole_r, relay_h/2])
    cylinder(r=hole_r, h=relay_h*2, center=true, $fn=20);

    translate([hole_offset + hole_r, relay_d - hole_offset - hole_r, relay_h/2])
    cylinder(r=hole_r, h=relay_h*2, center=true, $fn=20);

    translate([relay_w - hole_r - hole_offset, relay_d - hole_offset - hole_r, relay_h/2])
    cylinder(r=hole_r, h=relay_h*2, center=true, $fn=20);
  }

  module wire_connector() {
    difference() {
      light_green = [80/255, 200/255, 80/255];
      color(light_green)
      cube([relay_outlet_w, relay_outlet_d, relay_outlet_h]);

      translate([(relay_outlet_w - (relay_wire_connector_spacing*2 + relay_wire_connector_w*3))/2, -rerr, relay_wire_connector_spacing]) {
        cube([relay_wire_connector_w, relay_outlet_d + rerr2, 3.5]);

        translate([relay_wire_connector_spacing + relay_wire_connector_w, 0, 0])
        cube([relay_wire_connector_w, relay_outlet_d + rerr2, 3.5]);

        translate([(relay_wire_connector_spacing + relay_wire_connector_w)*2, 0, 0])
        cube([relay_wire_connector_w, relay_outlet_d + rerr2, 3.5]);
      }
    }
  }

  module relay_box() {
    light_blue = [0/255, 100/255, 200/255];
    color(light_blue)
    cube([relay_blue_box_w, relay_blue_box_d, relay_blue_box_h]);
  }

  module wire_bridge() {
    off_black = [40/255, 40/255, 47/255];
    color(off_black) {
      cube([wire_bridge_w, wire_bridge_d, wire_bridge_h]);

      translate([wire_bridge_spacing, 0, 0])
      cube([wire_bridge_w, wire_bridge_d, wire_bridge_h]);
    }
  }

  translate([0, 0, relay_h-rerr]) {
    translate([(relay_w - relay_outlet_w)/2, relay_outlet_y, 0])
    wire_connector();

    translate([(relay_w - relay_outlet_w)/2, relay_d - relay_outlet_y - relay_outlet_d, 0])
    wire_connector();

    translate([(relay_w - relay_blue_box_w)/2, relay_blue_box_y, 0])
    relay_box();

    translate([relay_w/2 - wire_bridge_spacing/2 - wire_bridge_w/2, wire_bridge_y, 0])
    wire_bridge();
  }

  txt_offset = 2;
  translate([(relay_w - relay_outlet_w)/2 + text_size/2 + relay_wire_connector_w/2, txt_offset, relay_h]) {
    translate([(relay_outlet_w - (relay_wire_connector_spacing*2 + relay_wire_connector_w*3))/2, -rerr, 0]) {
      txt("VCC");

      translate([relay_wire_connector_spacing + relay_wire_connector_w, 0, 0])
      txt("IN");

      translate([(relay_wire_connector_spacing + relay_wire_connector_w)*2, 0, 0])
      txt("GND");
    }
  }

  translate([(relay_w - relay_outlet_w)/2 + text_size/2 + relay_wire_connector_w/2, relay_d - txt_offset, relay_h]) {
    translate([(relay_outlet_w - (relay_wire_connector_spacing*2 + relay_wire_connector_w*3))/2, -rerr, 0]) {
      txt("NC");

      translate([relay_wire_connector_spacing + relay_wire_connector_w, 0, 0])
      txt("COM");

      translate([(relay_wire_connector_spacing + relay_wire_connector_w)*2, 0, 0])
      txt("NO");
    }
  }
}

// espAndShield();
// button();
// relay();
