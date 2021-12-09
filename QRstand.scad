include <support/polyround.scad>
include <support/linepath.scad>
include <support/roundedcube.scad>

/* height = 100;
presentation_angle = 60; */
qr_w = 80;
qr_d = 4.2;
border = 2;

tolerance = 2;
line_offset = 1;

base_w = 50;
base_d = 30;
base_h = 30;

rerr = 0.01;

translate([base_w/2 + 1, base_h, 0])
#cube([qr_d, qr_w, qr_w]);

linear_extrude(base_d) {
  path(polyRound([
    [0, 0, 0],
    [base_w, 0, 0],
    [base_w/2, 1, 90],
    [base_w/2, base_h, 0],
    [base_w/2, base_h+qr_w+tolerance, 0],
    [base_w/2 + qr_d + tolerance + line_offset, base_h+qr_w+tolerance, 0],
    [base_w/2 + qr_d + tolerance + line_offset, base_h+qr_w+tolerance-border-tolerance, 0],
  ]));

  translate([base_w/2, base_h-line_offset, 0])
  path(polyRound([
    [0, border+tolerance, 0],
    [0, 0, 0],
    [qr_d + tolerance + line_offset, 0, 0],
    [qr_d + tolerance + line_offset, border+tolerance, 0],
  ]));
}
