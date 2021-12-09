height = 51.5625;
width = 71.5625;
offset = 24;


// Normal stairs
/* run = 11; */
/* rise = 7.5; */

board_size = [120, 6];

stair_count = 11;
// Platform is 1 step below loft
run = (width-offset)/(stair_count-2);
// Platform is same height as loft
/* run = (width-offset)/(stair_count-1); */
rise = height/(stair_count);

steps = floor(height/rise) - 1;
angle = atan(rise/run);
rerr = 0.01;

text_size = rise-2;

color("black") {
  logging_size = 2;
  lines = [
    str("Run: ", run),
    str("Rise: ", rise),
    str(angle, "°")
  ];

  for (i=[1:len(lines)+1]) {
    translate([1, height - 1*i - logging_size*i, 0]) {
      text(lines[i-1], size=logging_size);
    }
  }
}

// Steps
for (i=[0:steps]) {
  translate([i*run, (i+1)*rise, z(3)]) {
    % color("blue", 0.5)
    square([run+rerr, rise+rerr]);

    translate([1, -rise+1, 0])
    color("black")
    text(str(i+1), size=text_size);
  }
}

translate([0, 0, z(1)])
difference() {
  // Board
  board();

  // Board top cut
  translate([-width, height, 0])
  square([width*3, height]);

  // Board bottom cut
  translate([-width, -height, 0])
  square([width*3, height]);

  // Board left cut
  translate([-width, 0, 0])
  square([width, height]);

  // Board right cut
  translate([width, 0, 0])
  square([width, height]);
}


// Board cutouts
# translate([0, 0, z(-1)])
board();

// Offset
% color("lightgrey", 0.3)
translate([width-offset, 0, z(2)])
square([offset, height]);

// Background
color("grey")
translate([0, 0, z(-2)])
square([width, height]);


function z(idx) = idx*rerr;

module board() {
  translate([-run, 0, 0])
  rotate([0, 0, angle])
  translate([0, -board_size.y, 0])
  square(board_size);
}
