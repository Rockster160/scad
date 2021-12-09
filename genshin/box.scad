include <buttons.scad>
use <../support/pushbutton.scad>

enc_fit_space = 0.8;
wall = 2;

inner_width = layout_width + enc_fit_space - height*2;
inner_depth = layout_depth - wall;
outer_width = layout_width + wall*2 + height*2;
outer_depth = layout_depth - wall + wall*2;
inner_offset = (outer_width - inner_width)/2;
ridge_slot_width = height + 0.7;
enc_height = 25;

board_width = 17.9;
board_depth = 32.85;
board_height = 1.6;

board_socket_h = 2.4;
board_socket_w = 7.5;
board_socket_d = 5.2;
board_socket_overlap = 4;

board_fit_padding = 0.4;

board_enc_w = board_width + wall*2 + board_fit_padding*2;
board_enc_d = board_depth + wall*2 + board_fit_padding*2;
board_enc_h = enc_height;

// vv From pushbutton
btn_height_with_legs = 7.4;
btn_height_without_legs = 4.2;
btn_height_without_btn = 3;
leg_height = btn_height_with_legs - btn_height_without_legs;
btn_w = 6;
btn_leg_width = 0.3;
btn_leg_depth = 0.7;
leg_offset = 0.2;
// ^^ From pushbutton
click_offset = 0.1;
wire_padding = 0.2;
btn_stand_height = enc_height - ridge_slot_width - btn_height_without_legs + click_offset;

color_metallic = [240/255, 240/255, 240/255];
color_pcb = [30/255, 60/255, 130/255];

// % translate([inner_offset - ridge_slot_width+enc_fit_space, wall, enc_height-height]) frame();

module inner() {
  translate([inner_offset, wall, wall])
  cube([inner_width, inner_depth, enc_height]);
}

module button_enc() {
  difference() {
    translate([0, 0, 0])
    cube([outer_width, outer_depth, enc_height]);

    inner();
    bridge();
  }
}

module bridge() {
  hull() {
    translate([inner_offset+rounding_error, wall, enc_height+rounding_error]) {
      rotate([0, 180, 0])
      ridge(layout_depth+wall, ridge_slot_width);
    }

    translate([inner_offset + inner_width + ridge_slot_width - rounding_error, wall, enc_height+rounding_error-ridge_slot_width]) {
      rotate([0, -90, 0])
      ridge(layout_depth+wall, ridge_slot_width);
    }
  }
}

module borders() {
  wire_spacing = 4;
  for (x=[0:buttons_horz-2]) {
    translate([wall*2 + width_offset*(x + 1), wall + wire_spacing, 0])
    cube([wall, inner_depth - wire_spacing*2, enc_height - ridge_slot_width]);
  }

  translate([inner_offset + wire_spacing, outer_depth/2, 0])
  cube([inner_width - wire_spacing*2, wall, enc_height - ridge_slot_width]);
}

module board() {
  // board_width
  // board_depth
  // board_height
  // board_socket_w
  // board_socket_d
  // board_socket_h
  // board_socket_overlap
  color(color_pcb) {
    cube([board_width, board_depth, board_height]);
  }

  color(color_metallic) {
    translate([board_width/2 - board_socket_w/2, board_depth - board_socket_overlap, board_height]) {
      cube([board_socket_w, board_socket_d, board_socket_h]);
    }
  }
}

module board_slot() {
  slot_w = board_socket_w + board_fit_padding*2;
  slot_d = board_socket_d + rounding_error;
  slot_h = board_socket_h + board_fit_padding*2;

  slot_offset_w = board_width/2 - board_socket_w/2 - board_fit_padding;
  slot_offset_d = board_depth;
  slot_offset_h = board_height - board_fit_padding;

  translate([slot_offset_w, slot_offset_d, slot_offset_h]) {
    cube([slot_w, slot_d, slot_h]);
  }
}

module board_enc() {
  // translate([wall, wall, wall])
  // translate([board_fit_padding, board_fit_padding, board_fit_padding])
  // board();

  cutout_size = 4;

  difference() {
    cube([board_enc_w, board_enc_d, board_enc_h]);

    translate([wall, wall, wall]) {
      cube([board_enc_w - wall*2, board_enc_d - wall*2, board_enc_h]);

      translate([board_fit_padding, board_fit_padding, board_fit_padding])
      board_slot();

      translate([0, 0, -wall/2]) {
        cube([cutout_size, board_enc_d - wall*2, cutout_size]);

        translate([board_enc_w - wall*2 - cutout_size, 0, 0])
        cube([cutout_size, board_enc_d - wall*2, cutout_size]);
      }
    }
  }
}

module cutouts() {
  wire_hole_d = 6;

  translate([-1, 10, 15])
  rotate([0, 90, 0]) cylinder(r=wire_hole_d/2, h=10);

  translate([-1, 25, 15])
  rotate([0, 90, 0]) cylinder(r=wire_hole_d/2, h=10);
}

module btn_stand(size) {
  wire_d = 0.5;
  wire_h = leg_height*2;
  btn_offset = size/2 - btn_w/2;

  wire_slot_w = btn_leg_depth + wire_padding*2;
  wire_slot_d = btn_leg_width + wire_d*2 + wire_padding*2;
  wire_slot_h = wire_h;

  stand_slot_offset_x = btn_offset + leg_offset/2 - wire_padding/2;
  stand_slot_offset_y = btn_offset - wire_slot_d;
  stand_slot_offset_z = btn_stand_height - wire_slot_h + rounding_error;

  difference() {
    cube([size, size, btn_stand_height]);

    translate([stand_slot_offset_x, stand_slot_offset_y, stand_slot_offset_z])
    cube([wire_slot_w, wire_slot_d, wire_slot_h]);

    translate([size - stand_slot_offset_x - wire_slot_w, stand_slot_offset_y, stand_slot_offset_z])
    cube([wire_slot_w, wire_slot_d, wire_slot_h]);

    translate([size - stand_slot_offset_x - wire_slot_w, size - stand_slot_offset_y - wire_slot_d, stand_slot_offset_z])
    cube([wire_slot_w, wire_slot_d, wire_slot_h]);

    translate([stand_slot_offset_x, size - stand_slot_offset_y - wire_slot_d, stand_slot_offset_z])
    cube([wire_slot_w, wire_slot_d, wire_slot_h]);
  }


  // translate([btn_offset, btn_offset, btn_stand_height - leg_height])
  // pushbutton();
}

module button_stands() {
  size = 10;

  for (x=[0:buttons_horz-1]) {
    for (y=[0:buttons_vert-1]) {
      x_offset = inner_offset + (width_offset * x) + width_offset/2;
      y_offset = wall + (width_offset * y) + width_offset/2;
      translate([x_offset - size/2, y_offset - size/2, 0]) {
        btn_stand(size);
      }
    }
  }
}

// difference() {
//   union() {
//     button_enc();
//
//     borders();
//
//     button_stands();
//
//     translate([-board_enc_w + wall, 0, 0])
//     board_enc();
//   }
//
//   cutouts();
// }
