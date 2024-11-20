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
// hole_spacing = 0.04;
hole_spacing = 0.4;

$fn=60;

function circumference(d) = PI * d;
function max_holes(outer_diameter) = floor(circumference(outer_diameter) / (hole_diameter + hole_spacing));

base_distance = stick_diameter/2 + hole_diameter/2;

module holes(count, offset) {
  for (i = [0:360/count:360]) {
    rotate([0, 0, i]) {
      translate([base_distance + (0.3*(offset+1)) + (offset*hole_diameter), 0, -0.5]) {
        cylinder(d=hole_diameter, h=drain_base_height + 1);
      }
    }
  }
}

module shower_drain() {
  echo("========== Shower Drain ==========");
  difference() {
    // Base
    cylinder(d=base_diameter, h=drain_base_height);

    // Add holes for water to drain
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

  // Add stick for pulling out
  translate([0, 0, drain_base_height]) {
    cylinder(d=stick_diameter, h=stick_height);
  }
}

shower_drain();
