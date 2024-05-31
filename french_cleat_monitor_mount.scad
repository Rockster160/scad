/* [Specs] */
// Distance between bolt holes
spacing = 70;
// Thickness of the plate (Not recommended to change)
thickness = 5;
// Distance from outer edge to the bolts (Not recommended to change)
padding = 3;
// Bore offset (non-standard) - if you need to change the origin of where the bores are drilled
// offset = 0;
offset = -2; // Weird unstandard mount has distance of 70 /between/ bores with a width of 5 instead of being 100 between center points.

/* Cleat */
// The width of the cleat. 12.7mm is 1/2" which is the standard size.
cleat_depth = 12.7;

/* [Hidden] */
m12_l = 12;
m12_hd = 8;
m12_hl= 3;
m12_sd = 4.5;
m12_offset = padding + m12_hd;
plate_size = spacing + m12_offset*2;
cleat_width = spacing - m12_l;

// model countersunk screw for 3d printing
// useful for creating attachment bores
// which fit these screws
// default values are for 3mm x 20mm screw with 6mm head (3.2mm bore for tolerance)
module countersink(
  l = 20,   // length
  hd = 6,   // head dia
  hl = 3,   // head length
  sd = 3.2, // shaft dia
  ph = 0,   // pocket hole height/depth
) {
  union() {
    translate([0, 0, -ph])
      cylinder(h=ph, r1=hd/2, r2=hd/2, $fn=60);
    cylinder(h=hl, r1=hd/2, r2=sd/2, $fn=60);
    cylinder(h=l, r1=sd/2, r2=sd/2, $fn=60);
  }
}

module frenchcleat(w=20, d=10) {
  linear_extrude(d)
    polygon([[0,0],[w,0],[0,w]]);
}

module bolt() {
  translate([0, 0, thickness])
  rotate([180, 0, 0])
    countersink(l=m12_l, hd=m12_hd, hl=m12_hl, sd=m12_sd);
}

module plate() {
  difference() {
    cube([plate_size, plate_size, thickness]);

    for (i=[m12_offset+offset, plate_size - m12_offset - offset]) {
      for (j=[m12_offset+offset, plate_size - m12_offset - offset]) {
        translate([i, j, 0])
         # bolt();
      }
    }
  }
}

module outline(sizeX, sizeY) {
  sizeX = sizeX == undef ? 0 : sizeX;
  sizeY = sizeY == undef ? sizeX : sizeY;

  difference() {
    square([sizeX, sizeY]);
    translate([0.5, 0.5, 0])
    square([sizeX-1, sizeY-1]);
  }
}

module plate_cleat() {
  translate([m12_offset + m12_l/2, 30, 0])
  translate([0, 0, cleat_depth + thickness])
  rotate([0, 90, 0])
    frenchcleat(cleat_depth, plate_size);
}

union() {
  plate();
  translate([-(m12_offset + m12_l/2), m12_offset + m12_l/2 + 10, 0]) {
    plate_cleat();
    translate([m12_offset + m12_l/2, 0, thickness])
    cube([plate_size, 30, cleat_depth]);
  }
}


// color("red")
// translate([m12_offset, m12_offset/2, 0])
// outline(70, 80);
//
// hole_dia=5;
// color("green")
// translate([m12_offset+(hole_dia/2), m12_offset+(hole_dia/2), 0])
// outline(70-hole_dia);
