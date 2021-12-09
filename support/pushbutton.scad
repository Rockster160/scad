module pushbutton() {
  color_black = [50/255, 50/255, 50/255];
  color_grey = [220/255, 220/255, 220/255];
  color_silver = [240/255, 240/255, 240/255];

  height_with_legs = 7.4;
  height_without_legs = 4.2;
  height_without_btn = 3;

  button_d = 3.4;
  button_r = button_d/2;
  button_h = height_without_legs - height_without_btn;

  dots_d = 0.9;
  dots_r = dots_d/2;
  dots_h = 0.1;
  dot_offset = dots_d/2 + 0.2;

  block_w = 6;
  block_h = height_without_btn;
  block_top_layer = 0.3;

  leg_width = 0.3;
  leg_depth = 0.7;
  leg_bend = 0.3;
  leg_bend_h = 0.7;
  leg_height = height_with_legs - height_without_legs;
  leg_points = [
    [0, 0],
    [-leg_bend, leg_bend_h],
    [0, leg_bend_h*2],
    [0, leg_height+0.5],

    [0+leg_width, leg_height+0.5],
    [0+leg_width, leg_bend_h*2],
    [-leg_bend+leg_width, leg_bend_h],
    [0+leg_width, 0],
  ];

  translate([block_w, 0, 0]) rotate([0, 0, 90]) {
    // Legs
    color(color_silver) {
      leg_offset = 0.2 + leg_depth/2;
      leg_coords = [leg_offset, block_w-leg_offset];
      for (i=leg_coords) {
        translate([-leg_width, i + leg_depth/2, 0]) {
          rotate([90, 0, 0]) {
            linear_extrude(leg_depth) polygon(leg_points);
          }
        }

        translate([block_w+leg_width, i - leg_depth/2, 0]) {
          rotate([90, 0, 180]) {
            linear_extrude(leg_depth) polygon(leg_points);
          }
        }
      }
    }

    translate([0, 0, leg_height]) {
      color(color_black) {
        // Block Bottom Layer
        cube([block_w, block_w, block_h - block_top_layer]);
      }

      color(color_grey) {
        // Block Top Layer
        translate([0, 0, block_h - block_top_layer])
        cube([block_w, block_w, block_top_layer]);
      }

      color(color_black) {
        // Button
        translate([block_w/2, block_w/2, block_h])
        cylinder(r=button_r, h=button_h, $fn=20);

        // Dots
        dot_coords = [dot_offset, block_w-dot_offset];
        for (x=dot_coords) {
          for (y=dot_coords) {
            translate([x, y, block_h])
            cylinder(r=dots_r, h=dots_h, $fn=20);
          }
        }
      }
    }
  }

  color(color_silver) {
    // -- Circuit
    canv_offset = block_w * 0.2;
    canv_w = block_w * 0.6;
    canv_h = block_h/4;
    line_h = 0.1;
    line_depth = 0.01;

    // -- Normally Open
    no_bridge_points = [
      [0, 0],
      [canv_w/4, 0],
      [canv_w/2, canv_h],

      [canv_w/2, canv_h+line_h],
      [canv_w/4, 0+line_h],
      [0, 0+line_h],
    ];
    no_end_points = [
      [canv_w/2, 0],
      [canv_w, 0],

      [canv_w, 0+line_h],
      [canv_w/2, 0+line_h],
    ];

    translate([0, 0, leg_height + canv_offset]) rotate([90, 0, 0]) {
      translate([canv_offset, 0, 0])
      linear_extrude(line_depth) {
        polygon(no_bridge_points);

        polygon(no_end_points);
      }

      translate([canv_offset, 0, -block_w-line_depth])
      linear_extrude(line_depth) {
        polygon(no_bridge_points);

        polygon(no_end_points);
      }
    }

    // -- Always Closed
    translate([0, block_w - canv_w - canv_offset, leg_height + canv_offset]) rotate([0, 0, 90]) {
      cube([canv_w, line_depth, line_h]);

      translate([0, -block_w-line_depth, 0])
      cube([canv_w, line_depth, line_h]);
    }
  }
}
