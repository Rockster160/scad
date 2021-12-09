use <support/in_to_mm.scad>
use <support/countersink.scad>
use <support/roundedcube.scad>

wall = 2;
can_tolerance = 1.5;
desk_tolerance = 0.5;

// Soda Can
// can_w = in_to_mm(2.6);
// can_h = in_to_mm(4.83); // 122.682

can_w = in_to_mm(3.5);
can_h = in_to_mm(4.83);
can_wp = can_w + can_tolerance*2;
can_hp = can_h + can_tolerance*2;
can_pr = can_wp/2;

desk_h = 25;
clip_w = can_wp/4;
clip_d = can_wp/2;
clip_h = 5;

holder_height = 50;

module can() {
  translate([0, 0, can_tolerance]) {
    // With Padding
    % translate([0, 0, -can_tolerance]) cylinder(r=can_pr, h=can_hp, $fn=60);
    // Can shape
    color("green") {
      cylinder(r=can_w/2, h=can_h, $fn=60);
    }
  }
}

// can();

difference() {
  cylinder(r=can_pr + wall*2, h=holder_height);

  translate([0, 0, wall])
  cylinder(r=can_pr, h=holder_height);

  translate([0, 0, -0.01])
  cylinder(r=10, h=holder_height);
}

translate([-clip_w/2, can_pr + clip_h/4, 0])
roundedcube([clip_w, wall*2, holder_height], radius=clip_h/2);

translate([-clip_w/2, can_pr, holder_height - clip_h]) {
  roundedcube([clip_w, clip_d, clip_h], center=false, radius=clip_h/2);

  translate([0, 0, -desk_h - clip_h - desk_tolerance*2]) {
    difference() {
      roundedcube([clip_w, clip_d, clip_h], center=false, radius=clip_h/2);

      translate([clip_w/2, clip_d/2, -0.01])
      countersink(8.5, 4.75, 4.25, 20);
    }
  }
}

// translate([-clip_w/2, can_pr + desk_h, holder_height - clip_h - desk_h]) {
//   # cube([desk_h, desk_h, desk_h]);
// }
