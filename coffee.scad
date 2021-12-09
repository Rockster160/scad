// Useful function if you're measuring in inches
function in_to_mm(in) = in * 25.4;

// Platform sizing measurements
w = in_to_mm(6); // Width of inside of drawer
l = in_to_mm(10); // Length of shelf
d = 20; // Height of the feet

// Hole spacing measurements
slot = 40; // Size of the holes
spacing = 5; // Space between each of the holes
border = 10; // Minimum space between the edge walls and the closest holes

// Config
tolerance = 0.4; // Offset sizing to fix discrepancy between measured and printed object
// ^^ Recommended to be nozzle/extrusion width
wall = 4; // Width of solids

// ----------------------- Shouldn't need to change anything below this line. ----------------------
slot_t = slot + tolerance;
platform_w = w - tolerance;
platform_l = l - tolerance;

// Offset/fix for thin walls
rerr = 0.01;

module platform() {
  // Base
  cube([platform_w, platform_l, wall]);

  // Walls
  cube([platform_w, wall, d]);
  cube([wall, platform_l, d]);

  translate([0, platform_l-wall, 0])
  cube([platform_w, wall, d]);

  translate([platform_w-wall, 0, 0])
  cube([wall, platform_l, d]);
}

module slots() {
  slot_spacing = slot_t + spacing;
  echo(str("slot_spacing = ", slot_spacing));
  profile_x_offset = (slot_spacing + (cos(45)*slot_spacing))/2;
  echo(str("profile_x_offset = ", profile_x_offset));

  profile_w = profile_x_offset;
  echo(str("profile_w = ", profile_w));
  profile_l = slot_spacing;
  echo(str("profile_l = ", profile_l));

  inside_w = platform_w - (wall*2);
  echo(str("inside_w = ", inside_w));
  inside_l = platform_l - (wall*2);
  echo(str("inside_l = ", inside_l));

  w_steps = floor((inside_w - border) / profile_w);
  echo(str("w_steps = ", w_steps));
  l_steps = floor((inside_l - border) / profile_l);
  echo(str("l_steps = ", l_steps));

  w_offset = (inside_w - (w_steps*profile_w))/2;
  echo(str("w_offset = ", w_offset));
  l_offset = (inside_l - (l_steps*profile_l))/2;
  echo(str("l_offset = ", l_offset));

  align_x = wall - 0.8 + w_offset + slot_t/2;
  echo(str("align_x = ", align_x));
  align_y = wall*2 - 1.4 + l_offset + slot_t/2;
  echo(str("align_y = ", align_y));

  for (x=[0:w_steps-1]) {
    for (y=[0:l_steps-1]) {
      offset = (x % 2 == 0) ? 0 : slot_spacing/2;

      if (!(offset > 0 && y == l_steps - 1)) { // Doesn't cut the top hole when the holes are offset
        translate([align_x + (x*profile_x_offset), align_y + (y*slot_spacing) + offset, 0]) {
          cylinder(r=slot_t/2, h=wall+rerr*2);
        }
      }
    }
  }
}

difference() {
  platform();

  translate([0, 0, -rerr])
  slots();
}
