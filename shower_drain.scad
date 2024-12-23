// Shower Drain (44.6mm)

include <support/vars.scad>

// Next time:

tol = tolerance("near");
drain_diameter = 44.6;
lip = 2.5;
base_diameter = drain_diameter - lip - tol;
drain_base_height = 3;
stick_diameter = 6;
stick_height = 30;
hole_diameter = 3;
hole_spacing = 0.4;

wall = 3;

$fn=60;

function circumference(d) = PI * d;
function max_holes(outer_diameter) = floor(circumference(outer_diameter) / (hole_diameter + hole_spacing));

base_distance = stick_diameter/2 + hole_diameter/2;

module holes() {
  useable_width = (base_diameter - stick_diameter)/2;
  rows = floor(useable_width / (hole_diameter + hole_spacing));
  for (n = [0:rows-1]) {
    radius = base_distance + (n * hole_diameter) + (n * hole_spacing+1);
    count = max_holes(radius*2);
    for (i = [0:360/count:360]) {
      rotate([0, 0, i]) {
        translate([radius, 0, -0.5]) {
          cylinder(d=hole_diameter, h=drain_base_height + 1);
        }
      }
    }
  }
}

module radial_lines(count, length, thickness) {
  for (i = [0:360/count:360]) {
    rotate([0, 0, i]) {
      translate([length/2-1, 0, drain_base_height/2]) {
        cube([length, thickness, drain_base_height], center=true);
      }
    }
  }
}

module shower_drain() {
  echo("========== Shower Drain ==========");
  // difference() {
    // cylinder(d=base_diameter, h=drain_base_height);
  //   holes();
  // }
  difference() {
    cylinder(d=base_diameter, h=drain_base_height);
    translate([0, 0, -0.5])
    cylinder(d=base_diameter-wall, h=drain_base_height+1);
  }
  radial_lines(8, base_diameter/2, hole_diameter);

  // Add stick for pulling out
  translate([0, 0, 0]) {
    cylinder(d=stick_diameter, h=stick_height+drain_base_height);
  }
}

shower_drain();
