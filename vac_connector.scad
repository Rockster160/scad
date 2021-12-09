include <support/polyround.scad>
include <support/roundedcube.scad>

$fn=100;

inside = 45 + 0.5;
inside_r = inside/2;
wall = 2.5;
wall2 = wall*2;
indent_wall = 2;
height = 32;
rerr = 0.01;
rerr2 = rerr*2;

module rotate_about_pt(z, y, pt) {
  translate(pt)
  rotate([0, y, z])
  translate(-pt)
  children();
}

module adapter() {
  difference() {
    translate([0, 0, rerr])
    cylinder(r=inside_r + wall, h=height-rerr2);

    cylinder(r=inside_r, h=height);

    translate([0, inside_r -1, 11])
    cutout();

    rotate_about_pt(180, 0, [0, 0, 0])
    translate([0, inside_r -1, 11])
    cutout();

    wall_center = (inside + wall)/2;
    rounded_chamfer(wall_center + wall/2, wall/2, "outside");
    rounded_chamfer(wall_center - 1.5, wall/2, "inside");

    rotate_about_pt(0, 180, [0, 0, height/2]) {
      rounded_chamfer(wall_center + wall/2, wall/2, "outside");
      rounded_chamfer(wall_center - 1.5, wall/2, "inside");
    }

    translate([5, 0, 13])
    rotate([90, 180, -90])
    linear_extrude(10)
    polygon([[-inside_r+0.3, 0], [inside_r-0.3, 0], [inside_r+indent_wall/2, 13], [-inside_r-indent_wall/2, 13]]);
  }
}

module rounded_chamfer(dia, rnd, direction) {
  rotation = direction == "inside" ? [0, 180, 180] : [0, 0, 90];

  rotate([0, direction == "inside" ? 180 : 0, 0])
  rotate_extrude()
  scale([1+rerr, 1+rerr, 1+rerr])
  translate([dia, 0, 0])
  rotate(rotation)
  polygon(polyRound([[0, 0, 0], [0, rnd/2, 0], [0, 0, rnd], [rnd/2, 0, 0]]));
}

module cutout_shape() {
  points = [
    [0, 0, 1],
    [9, 0, 1],
    [10, 8, 1],
    [4.5, 12, 10],
    [-1, 8, 1],
  ];

  linear_extrude(0.1)
  translate([-4.5, 0, 0])
  polygon(polyRound(points));
}

module cutout() {
  translate([0, 0, 10])
  rotate([-90, 0, 0])
  hull() {
    translate([0, -2.5, 5])
    scale([1.5, 1.5, 1.5])
    cutout_shape();

    cutout_shape();
  }
}

module straight_nozzle() {
  base = 10;
  hole_r = 8;
  flen = 40;
  nlen = 60;

  difference() {
    translate([0, 0, rerr])
    cylinder(r=inside_r + wall, h=base-rerr2);

    cylinder(r=inside_r, h=base);
  }

  translate([0, 0, base - rerr])
  difference() {
    translate([0, 0, rerr])
    cylinder(flen, inside_r + wall, hole_r + wall);

    cylinder(flen+rerr2, inside_r, hole_r);
  }

  translate([0, 0, (flen + base) - rerr2])
  difference() {
    translate([0, 0, rerr])
    cylinder(nlen, hole_r + wall, hole_r + wall);

    cylinder(nlen+rerr2, hole_r, hole_r);

    translate([-hole_r-wall, -(hole_r+wall)*2, nlen])
    rotate([0, 30, 0])
    cube([(hole_r+wall)*4, (hole_r+wall)*4, (hole_r+wall)*4]);
  }
}

module rounded_rect(w, d, r=1) {
  hull() {
    translate([r, r, 0])
    circle(r=r);

    translate([w-r, r, 0])
    circle(r=r);

    translate([w-r, d-r, 0])
    circle(r=r);

    translate([r, d-r, 0])
    circle(r=r);
  }
}

module round_rect_tube_inner(w, d, h, r=1, tubewall=wall) {
  translate([tubewall/2, tubewall/2, -rerr])
  linear_extrude(h+rerr2)
  rounded_rect(w-tubewall, d-tubewall, r);
}

module round_rect_tube(w, d, h, r=1, tubewall=wall) {
  difference() {
    linear_extrude(h)
    rounded_rect(w, d, r);

    round_rect_tube_inner(w, d, h, r, tubewall);
  }
}

module square_nozzle() {
  base = 10;
  hole_r = 5;
  flen = 60;
  nlen = 50;
  blen = 50;
  w = inside - 10;
  d = inside_r - 5;

  difference() {
    translate([0, 0, rerr])
    cylinder(r=inside_r + wall, h=base-rerr2);

    cylinder(r=inside_r, h=base);
  }

  translate([0, 0, base - rerr])
  difference() {
    translate([0, 0, rerr])
    cylinder(flen, inside_r + wall, hole_r + wall);

    cylinder(flen+rerr2, inside_r, hole_r);

    translate([-w/2, -d/2, 0])
    translate([wall/2, wall/2, -rerr])
    linear_extrude(base + flen + nlen+rerr2)
    rounded_rect(w-wall, d-wall, r=3);
  }

  difference() {
    translate([-w/2, -d/2, 0])
    round_rect_tube(w, d, base + flen + nlen, r=3);

    translate([0, 0, -rerr])
    cylinder(r=inside_r, h=base);

    translate([0, 0, base - rerr2])
    cylinder(flen+rerr2, inside_r, hole_r);

    translate([0, 2.4, -9])
    translate([-w/2, -d/2, 0])
    translate([0, 0, base + flen + nlen])
    rotate([30, 0, 0])
    round_rect_tube_inner(w, d, blen, r=3);
  }

  difference() {
    translate([0, 2.4, -9])
    translate([-w/2, -d/2, 0])
    translate([0, 0, base + flen + nlen]) {
      rotate([30, 0, 0])
      round_rect_tube(w, d, blen, r=3);
    }

    translate([-w/2 - wall, -d*2 - 11.3, base + flen + nlen]) {
      rotate([-10, 0, 0])
      cube([w+wall2, d+wall2, blen]);
    }
  }
}

function angled_height(d1, d2, angle) = ((max([d1, d2]) - min([d1, d2]))/sin(angle)) * sin(90 - angle);

module adapter_tube(inner_rad1, inner_rad2, angle) {
  height = angled_height(inner_rad1, inner_rad2, angle);

  difference() {
    cylinder(height, inner_rad1 + wall, inner_rad2 + wall);

    translate([0, 0, -rerr])
    cylinder(height + rerr*2, inner_rad1, inner_rad2);
  }
}

module converter(size, angle=30, base=10, end_base=20) {
  // Adapter
  difference() {
    translate([0, 0, rerr])
    cylinder(r=inside_r + wall, h=base-rerr2);

    cylinder(r=inside_r, h=base);
  }

  // New size
  height = angled_height(size/2, inside_r, angle);
  translate([0, 0, base + height - rerr2])
  linear_extrude(end_base)
  difference() {
    circle(size/2 + wall);

    circle(size/2);
  }

  // Connect the two
  translate([0, 0, base-rerr])
  adapter_tube(inside_r, size/2, angle);
}

// round_rect_tube(20, 10, 20, r=3);

// translate([0, 0, height - 1])
// straight_nozzle();

// Brush nozzle
// translate([0, 0, height - 1])
// converter(35.5);

// Skill Saw
translate([0, 0, height - 1])
converter(35.5);

// Table Saw
// translate([0, 0, height - 1])
// converter(64);

// Miter Saw
// translate([0, 0, height - 1])
// converter(64.2);

// Sander
// difference() {
//   translate([0, 0, height - 1])
//   converter(63.7);
//
//   translate([0, 0, height + 43]) // Hardcoded offset
//   cube([3, 80, 5], center=true);
// }

// translate([0, 0, height - 1])
// square_nozzle();

adapter();


// include <support/in_to_mm.scad>
// module can_holder() {
//   base = 15;
//   top = 30;
//   can_w = in_to_mm(2.6);
//   can_h = in_to_mm(4.83);
//   insert_w = in_to_mm(1 + 3/4);
//
//   h=40;
//   r=(can_w + 5 + wall2)/2;
//
//   offset = angled_height(insert_w, r, 50);
//
//   cylinder(r=insert_w/2, h=base);
//
//   translate([0, 0, base])
//   cylinder(offset, insert_w/2, r);
//
//   translate([0, 0, base + offset]) {
//     difference() {
//       cylinder(r=r, h=top);
//
//       translate([0, 0, rerr])
//       cylinder(r=r - wall, h=top);
//     }
//   }
// }
// can_holder();
