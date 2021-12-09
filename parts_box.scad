include <support/roundedcube.scad>

min_spacing = 2;
width = 150.5;
depth = 86;
// min_spacing = rands(0, 50, 1)[0];
// width = rands(20, 400, 1)[0];
// depth = rands(20, 400, 1)[0];

wall = 2;

hdrender = 0 == 0;
if (hdrender) {
  $fn=100;
}

module donut_edge(round_r, inner_r=0) {
  rerr=0.01;
  adj_inner_r = (inner_r <= 0) ? 0 : inner_r - rerr;

  rotate_extrude()
  translate([round_r + adj_inner_r + rerr, round_r + rerr, -rerr])
  rotate([0, 0, 180])
  difference() {
    translate([rerr, rerr, 0])
    square(round_r);

    intersection() {
      circle(round_r+rerr*3);
      square(round_r);
    }
  }
}

module slot() {
  if (hdrender) {
    difference() {
      cylinder(r=6, h=25);

      translate([0, 0, wall])
      cylinder(r=4.1, h=25, $fn=6);
    }

    translate([0, 0, wall-0.07])
    donut_edge(4, 6-0.07);
  } else {
    color("grey")
    cylinder(r=9, h=10);
  }
}

slotw = 18; // Width + ramp
xcount = floor(width / (slotw + min_spacing));
ycount = floor(depth / (slotw + min_spacing));

xspacing = (width - (slotw * xcount)) / xcount;
yspacing = (depth - (slotw * ycount)) / ycount;

if (hdrender) {
  roundedcube([width, depth, wall]);
} else {
  cube([width, depth, wall]);
}
translate([xspacing/2 + slotw/2, yspacing/2 + slotw/2, 0]) {
  for (x=[0:xcount-1]) {
    for (y=[0:ycount-1]) {
      translate([x * (xspacing + slotw), y * (yspacing + slotw), 0]) {
        slot();
      }
    }
  }
}

module testingblocks() {
  xpad = xspacing/2;
  ypad = yspacing/2;

  # translate([0, ypad/2 + slotw/2, 0]) cube([xpad, xpad, 10.1]);
  # translate([width-xpad, ypad/2 + slotw/2, 0]) cube([xpad, xpad, 10.1]);

  # translate([xpad/2 + slotw/2, 0, 0]) cube([ypad, ypad, 10.1]);
  # translate([xpad/2 + slotw/2, depth-ypad, 0]) cube([ypad, ypad, 10.1]);
}
if ($preview) {
  testingblocks();
}

echo(str("xspacing = ", xspacing));
echo(str("yspacing = ", yspacing));
