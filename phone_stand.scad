include <support/polyround.scad>
include <support/linepath.scad>
include <support/roundedcube.scad>

height = 40;
presentation_angle = 70;
// Vert    = 90
// Default = 70
// Flat    = 0
// 10.25

// Advanced
bump_h = 27; // 25 normally
foot_angle = 15;
wall_height = 65;
platform_width = 25; // 20 normally
depth = 50;
wall = 1;

round_radius = 2;
slot_size = 10;

f1 = [0, 0, 0];
// 40/12
// 20/5.17
b1x = (height + bump_h) * cos(90-foot_angle);
b1 = [b1x, height + bump_h, 5];

s1 = [b1.x + (bump_h * sin(foot_angle)), height, 5];
s2 = [b1.x + platform_width, s1.y, 5];

d1x = wall_height * cos(presentation_angle);
d1y = wall_height * sin(presentation_angle);
d1 = [s2.x + d1x, s2.y + d1y, 5];

f2 = [d1.x + (d1.y * cos(90-foot_angle)), 0, 0];

difference() {
  linear_extrude(depth)
  path(polyRound([
    f1,
    b1,
    s1,
    s2,
    d1,
    f2,
  ]), wall);

  if (true || !$preview) {
    translate([0, 0, depth/2]) {
      // Front foot
      # roundedcube([10, 10, 10], center=true, radius=round_radius);

      // Back foot
      translate([f2.x, 0, 0])
      # roundedcube([10, 10, 10], center=true, radius=round_radius);

      // Bump/touch slot
      translate([b1.x, s2.y + 10, 0])
      # roundedcube([10, 10, depth - 15], center=true, radius=round_radius);

      // Seat/Charge slot
      translate([s1.x, s1.y + 10 - wall - round_radius, 0])
      # roundedcube([13, 20, 13], center=true, radius=round_radius);
    }
  }
}
