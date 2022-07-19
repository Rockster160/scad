include <support/in_to_mm.scad>

$fn = 100;
if (!$preview) {
}

base_cir = 102/2;
handle_d = 53.5;
handle_w = 112 - handle_d/2;
clip_d = 22;
clip_w = 5;

floor_gap = 7.5;
plug_gap = 1.5;

height = 35;
wall = 5;
friction_tol = 0.4;
t = friction_tol + 0.05;
charge_hole = 9;
charge_offset = 67;
charge_wire_bridge = 20;
wire_w = 4;

module handle_outline(include_walls=false) {
  base_cir_outline = include_walls ? (base_cir + wall + t) : base_cir;
  handle_d_outline = include_walls ? (handle_d + wall*2 + t*2) : handle_d;

  translate([(handle_w + base_cir_outline)/2, 0, 0])
  square(size=[handle_w + base_cir_outline, handle_d_outline], center=true);

  round_offset = include_walls ? -wall/2 : 0;
  translate([base_cir_outline + handle_w + round_offset, 0, 0])
  circle(handle_d_outline/2);
}

module outline(include_walls=false) {
  base_cir_outline = include_walls ? (base_cir + wall + t) : base_cir;

  circle(base_cir_outline);

  if (!include_walls) {
    translate([-base_cir_outline, 0, 0])
    square(size=[clip_w*3, clip_d], center=true);
  }

  handle_outline(include_walls);
}

difference() {
  union() {
    difference() {
      linear_extrude(height)
      outline(include_walls=true);

      translate([0, 0, wall])
      linear_extrude(height)
      outline();
    }
    linear_extrude(wall + floor_gap)
    difference() {
      # handle_outline();

      circle(base_cir + 20);
    }
  }

  charger_x = base_cir + handle_w + handle_d/2 - charge_offset;
  charger_y = wall - plug_gap;
  translate([charger_x, 0, charger_y])
  linear_extrude(wall + floor_gap + plug_gap)
  circle((charge_hole/2)+friction_tol);

  translate([charger_x - charge_wire_bridge/2, 0, charger_y])
  linear_extrude(wall + floor_gap + plug_gap)
  square(size=[charge_wire_bridge, charge_hole+friction_tol], center=true);

  translate([charger_x - 40, 0, charger_y])
  linear_extrude(wall + floor_gap + plug_gap)
  square([50, wire_w], center=true);

  translate([base_cir + 10, 0, -0.1])
  linear_extrude(20)
  circle(10);
}
