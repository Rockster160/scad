include <support/vars.scad>
include <support/polyround.scad>
include <support/linepath.scad>
include <support/countersink.scad>

// Slightly too small. Need to increase the charger_dia tolerance, mostly due to squish from printing

$fn=30;

case_width = 60;
case_height = 50;

charger_dia = 27.31 + tolerance("friction");
charger_d = 7.5;
conn_wire_leng = 10;
conn_wire_dia = 3.7 + tolerance("tight");
wire_dia = 2.65 + tolerance("tight");

back_wall = wall_size("paper");

module centercube(pos) {
  translate([-pos.x/2, -pos.y/2, 0])
  cube([pos.x, pos.y, pos.z]);
}

module charger() {
  cylinder(r=charger_dia/2, h=charger_d, center=true);

  offset = 1;
  translate([charger_dia/2, 0, 0])
  translate([-offset, 0, 0]) {
    rotate([0, 90, 0])
    cylinder(r=conn_wire_dia/2, h=conn_wire_leng+offset);

    rotate([0, 90, 0])
    cylinder(r=wire_dia/2, h=30);
  }
}

//charger();

difference() {
  linear_extrude(case_width)
  path(polyRound([
    [0, 0, 0],
    [0, case_height, 0],
    [case_height/2, case_height/2, 0],
  ]), charger_d/2 + back_wall); //

  translate([-back_wall-rerr, case_height/2, case_width/2]) {
    rotate([0, -90, 0]) {
      charger();
      translate([charger_dia/2 - 1, 0, 0]) {
        translate([0, -conn_wire_dia/2, 0])
        cube([conn_wire_leng+2, conn_wire_dia, charger_d]);
        translate([0, -wire_dia/2, 0])
        cube([30, wire_dia, charger_d]);
      }
      cylinder(r=charger_dia/4, h=20, center=true);

      translate([0, -6, 0])
      rotate([45, 0, 0])
      translate([0, 0, -18])
      drywall_countersink(d=10);
    }
  }
}
