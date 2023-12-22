use <support/arc_rad_from_wh.scad>
use <support/in_to_mm.scad>

width = in_to_mm(7.5625);
depth = 31;

outer_rad = arc_rad_from_wh(width, depth);

wall = 5;
rerr = 0.01;
rerr2 = rerr*2;
inner_width = 4.5;
full_width = 150;
clip_height = 20;


function point_on_semi_circle_x(y_coord, radius) = sqrt(radius^2 - y_coord^2);
function angle_on_semi_circle(y_coord, radius) = acos(y_coord / radius);

module place_on_circle(y_coord) {
  circle_rad = outer_rad;
  // circle_rad = full_width/2;
  mod_y_coord = y_coord % (0.001 + circle_rad);
  radius = circle_rad;
  x_coord = point_on_semi_circle_x(mod_y_coord, radius);
  angle = angle_on_semi_circle(mod_y_coord, radius);

  translate([x_coord, mod_y_coord, 0]) {
    rotate([0, 0, -angle]) {
      children();
    }
  }
}

module arc(w, h, d) {
  $fn = 100;
  difference() {
    translate([0, outer_rad, 0]) cylinder(r=outer_rad, h=h);

    translate([0, outer_rad, 0]) translate([0, d, -0.5]) cylinder(r=outer_rad, h=h+1);

    translate([w/2, 0, -0.5]) cube([outer_rad, outer_rad*2, h+1]);
    translate([-w/2 - outer_rad, 0, -0.5]) cube([outer_rad, outer_rad*2, h+1]);
  }
}

module space_arc() {
  translate([0, wall, wall]) {
    arc(full_width+1, clip_height, inner_width);
  }
}

module donut() {
  $fn = 100;
  arc_deg = 60;

  translate([0, outer_rad + (inner_width/2) + wall, wall+(inner_width/2)])
  rotate([0, 0, 270-(arc_deg/2)])
  rotate_extrude(angle=arc_deg)
  translate([outer_rad, 0, 0])
  circle(r=inner_width/2);
}

module showerclip() {
  difference() {
    arc(full_width, clip_height, inner_width + wall*2);

    translate([0, 0, inner_width/2])
    space_arc();
    donut();
  }
}

module old_electric_razor() {
  razor_width = 37.5;
  razor_depth = 30;
  razor_height = clip_height;
  razor_walls = 3;

  razor_outer_width = razor_width + razor_walls*2;

  translate([-razor_outer_width/2, -3, 0]) {
    difference() {
      cube([razor_outer_width, razor_depth, razor_height]);

      translate([razor_walls, 1, -0.5]) {
        cube([razor_width, razor_depth, razor_height+1]);
      }

      tooth = 5;
      translate([-rerr-0.5, tooth, -razor_height+6]) {
        cube([razor_outer_width+1, razor_depth - tooth*2, razor_height]);
      }
    }
  }
}

module new_electric_razor() {
  razor_width = 31;
  razor_depth = 35;
  angle = 20;
  razor_walls = 7;
  razor_height = clip_height;

  razor_outer_width = razor_width + razor_walls*2;

  translate([-razor_outer_width/2, -2, 0]) {
    difference() {
      cube([razor_outer_width, razor_depth, razor_height]);

      translate([razor_walls, 1, -0.5]) {
        cube([razor_width, razor_depth, razor_height+1]);
      }

      x_off = sin(angle) * razor_height;

      vertical_offset = 12;
      // This is where to place the angle. Higher number gives more of a "foot"
      y_off = razor_height - (cos(angle) * razor_height) - (sin(angle) * ((razor_depth/2)+vertical_offset));
      // 6 above is magic

      difference() {
        translate([-rerr-0.5, 0, 0])
        translate([0, 1-x_off, y_off])
        rotate([-angle, 0, 0])
        cube([razor_outer_width+1, razor_depth*2, razor_height]);

        translate([-1, -razor_depth + 1, -razor_height])
        cube([razor_outer_width+3, razor_depth, razor_height*2]);
      }
    }
  }
}

module manual_razor() {
  mr_w = 16;
  mr_d = 13;
  mr_h = clip_height;
  mr_a_w = 3;
  mr_a_h = 5;
  walls = 3;

  mr_outer_width = mr_w + walls*2;

  translate([-mr_outer_width/2, -1, 0]) {
    difference() {
      cube([mr_outer_width, mr_d, mr_h]);

      translate([walls, 1, -0.5])
      cube([mr_w, mr_d+0.5, mr_h+1]);
    }

    translate([mr_w/2 + walls - mr_a_w/2, 0, 0])
    cube([mr_a_w, mr_d, mr_a_h]);
  }
}

module full() {
  showerclip();

  translate([0, outer_rad, 0])
  rotate([0, 0, -90]) {
    distances = 40;
    total = distances*3;
    start = -total/2 - distances/2;

    place_on_circle(start + (distances*1))
    old_electric_razor();

    place_on_circle(start + (distances*2.1))
    new_electric_razor();

    place_on_circle(start + (distances*3))
    manual_razor();
  }
}

full();
