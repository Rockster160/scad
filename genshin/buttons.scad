use <../support/roundedcube.scad>

width = 15.5;
space = 0.75;
padding = 2;
height = 2;

buttons_horz = 6;
buttons_vert = 2;

rounding_error = 0.01;

offset = padding + space;
width_offset = width + padding + space*2;
button_width = width + padding*2 + space*2;
layout_width = button_width*buttons_horz - padding*(buttons_horz-1);
layout_depth = button_width*buttons_vert - padding*(buttons_vert-1);

module buttoncap() {
  union() {
    smaller = 0.6;
    translate([offset + smaller/2, offset + smaller/2, 0])
    roundedcube([width - smaller, width - smaller, height]);

    translate([offset + width/3, width, 0])
    roundedcube([width/3, offset*2, height]);

    difference() {
      size = width + space*2 + padding*2;
      cutout = width + space*2;

      cube([size, size, height]);

      translate([padding, padding, -0.5])
      cube([cutout, cutout, height+1]);
    }
  }
}

module layout() {
  union() {
    for (x=[0:buttons_horz-1]) {
      for (y=[0:buttons_vert-1]) {
        translate([width_offset*x, width_offset*y, 0])
          buttoncap();
      }
    }
  }
}

module ridge(d, h) {
  translate([-rounding_error, d + 0.5, h+rounding_error])
    rotate([90, 90, 0])
    linear_extrude(d + 1)
    polygon([[0, 0],[h + rounding_error, 0],[0, h + rounding_error]]);
}

module frame() {
  difference() {
    layout();

    ridge(layout_depth, height);
    translate([layout_width, layout_depth, 0])
    rotate([0, 0, 180])
    ridge(layout_depth, height);
  }
}

module icon(file, frame_offset) {
  portrait = true;
  resize_x = portrait ? button_width-0.5 : 0;
  resize_y = portrait ? 0 : button_width-0.5;
  translate([0, 0, -frame_offset]) {
    difference() {
      scale([1, 1, 0.3])
        resize([resize_x, resize_y, 10], auto=true)
        surface(file=file, convexity=1, center=true);

      translate([0, 0, -1.5 + frame_offset])
      cube([button_width*2, button_width*2, 3], center=true);
    }
  }
}

module icons() {
  icon_offset = padding + space + width/2;
  multiplier = width_offset;
//   rgb(0, 0, 0) {
    translate([icon_offset, layout_depth - icon_offset, 0]) {
      // // [0,0] Events
      // translate([multiplier*0, -multiplier*0, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/events.png", 1.2);
      // // [1,0] BP
      // translate([multiplier*1, -multiplier*0, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/bp.png", 1.2);
      // // [2,0] Wish
      // translate([multiplier*2, -multiplier*0, height])
      // translate([0.2, -0.5, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/wish.png", 1.2);
      // // [3,0] Book
      // translate([multiplier*3, -multiplier*0, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/book.png", 1.25);
      // // [4,0] Items
      // translate([multiplier*4, -multiplier*0, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/items.png", 1.22);
      // // [5,0] Character
      // translate([multiplier*5, -multiplier*0, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/character.png", 1.22);
      // // [0,1] Cursor
      // translate([multiplier*0, -multiplier*1, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/cursor.png", 2);
      // // [1,1] Quests
      // translate([multiplier*1, -multiplier*1, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/quests.png", 2.07);
      // // [2,1] Sight
      // translate([multiplier*2, -multiplier*1, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/sight.png", 1.19);
      // // [3,1] Co-op
      // translate([multiplier*3, -multiplier*1, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/co_op.png", 1.2);
      // // [4,1] Friends
      // translate([multiplier*4, -multiplier*1, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/friends.png", 1.25);
      // // [5,1] Party
      // translate([multiplier*5, -multiplier*1, height])
      // translate([0, 0, 0])
      // icon("/Users/rocconicholls/code/scad/assets/genshin/party.png", 1.23);
    }
  // }
}

module full() {
  union() {
    frame();

    // icons();
  }
}
// full();
