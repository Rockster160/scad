module countersink(hd, hl, sd, sl, d=0, t=0.3, $fn=60) {
  // hd -- Head Diameter
  // hl -- Head Length
  // sd -- Shaft Diameter
  // sl -- Shaft Length
  // d -- Countersink Depth
  // t -- Tolerance

  translate([0, 0, -hl])
  cylinder(hl, sd/2+t, hd/2+t);

  translate([0, 0, -sl - hl + 0.01])
  cylinder(r=sd/2+t, h=sl+t);

  if (d > 0) {
    translate([0, 0, -0.01])
    cylinder(r=hd/2+t, h=d);
  }
}

// Black 1 1/4
module drywall_countersink(hd=8, hl=3.5, sd=3.75, sl=31.5, d=0, t=0.3, $fn=60) {
  countersink(hd, hl, sd, sl, d, t, $fn);
}

// Gold 2 1/2
module gold_countersink(hd=8.5, hl=4.75, sd=4.25, sl=64.75, d=0, t=0.3, $fn=60) {
  countersink(hd, hl, sd, sl, d, t, $fn);
}

// countersink(8, 3.5, 3.75, 31.5);

// Black 1 1/4 - 8,   3.5,  3.75,  31.5
// Black 1 5/8 - 8,   3.5,  3.75,  40.5
// Grey  2 1/2 - 9,   4,    5,     62.75
// Gold  2 1/2 - 8.5, 4.75, 4.25,  64.75
// Black 3     - 8,   3.5,  4.4,   75.5
// Grey  4     - 8.7, 3.5,  5,    101.6
// Silver  3/4 - 7.5, 3,    3.8,   18.75
