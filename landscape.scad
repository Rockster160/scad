function in2ft(inches) = inches/12;
plane = in2ft(4);

stair_run = in2ft(10);
stair_rise = in2ft(8);
top_stair_count = 5;

width = 8 + plane;
depth = 44;
height = 7.5;
pad = 19;
ramp_w = in2ft(48 + 4);
// ramp_w = width;

stair_w = width - ramp_w;
stair_d = depth - pad;

module ramp(w, d, angle) {
  h = d * tan(angle);
  translate([0, 0, h])
  rotate([0, 90, 0])
  linear_extrude(w)
    polygon([
      [0, d],
      [h, d],
      [h, 0],
    ]);
}

module ramp_points(w, d, h) {
  angle = atan(d / h);
  echo(str("ramp angle = ", 90 - angle));
  translate([0, 0, h])
  rotate([0, 90, 0])
  linear_extrude(w)
    polygon([
      [0, d],
      [h, d],
      [h, 0],
    ]);
}

module stairs(count, w) {
  rotate([90, 0, 90])
    linear_extrude(w)
    for (i=[0:count-1]) {
      translate([stair_run * i, 0, 0])
        square([stair_run, stair_rise * (i + 1)]);
    }
}

// Flat Pad
translate([0, stair_d, 0])
  cube([width, pad, height]);

// Ramp
color("green")
translate([stair_w, 0, 0])
  ramp_points(ramp_w, stair_d, height);
color("green")
translate([stair_w, 0, plane])
  ramp_points(plane, stair_d, height);

// Stairs
num_stairs = ceil(height / stair_rise) - 1;
base_stairs = num_stairs - top_stair_count;

stairs(base_stairs, stair_w);
translate([0, stair_run * base_stairs, 0])
  cube([stair_w, stair_d - (stair_run * base_stairs), stair_rise * base_stairs]);

remaining_height = height - (base_stairs * stair_rise);
remaining_stairs = ceil(remaining_height / stair_rise) - 1;

translate([0, (stair_d) - (remaining_stairs * stair_run), base_stairs * stair_rise]) {
  stairs(remaining_stairs, stair_w);
}

// Bottom
bot_w = 18;
bot_d = 8 + in2ft(7);

color("teal")
translate([-bot_w + width, -bot_d, -plane])
cube([bot_w, bot_d, plane]);

// Top
top_w = 11;
top_d = 20;

color("teal")
translate([-top_w + width, depth, height - plane]) {
  difference() {
    cube([top_w, top_d, plane]);

    translate([top_w - 3 + 0.01, top_d - (3 + in2ft(8)) + 0.01 - (2 + in2ft(4)), -0.01])
    cube([3, 3 + in2ft(8), 3]);
  }
}

// AC
ac_size = [in2ft(31), in2ft(31), in2ft(35 + 6)];
if ($preview) {
  color("red")
  translate([1, 8, base_stairs * stair_rise])
    cube(ac_size);
} else {
  color("red")
  translate([-ac_size.x - 1, 20, 0])
    cube(ac_size);
}
