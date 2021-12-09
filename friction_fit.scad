$fn = 30;

width = 2;
length = 10;
height = 5;
padding = 5;

fit_per_side = 0.4;
round_error = 0.01;

// 0.5 loose fit
// 0.4 very tight push fit
// 0.3 slam fit

difference() {
  cube([length+padding, width+padding, height]);

  translate([padding/2 + width/2, padding/2 + width/2, -round_error])
  hull() {
    cylinder(r=width/2 + fit_per_side, h=height+round_error*2);

    translate([length - width, 0, 0]) {
      cylinder(r=width/2 + fit_per_side, h=height+round_error*2);
    }
  }
}

translate([padding/2 + width/2, width+padding + width, 0])
// translate([padding/2 + width/2, padding/2 + width/2, -round_error])
hull() {
  cylinder(r=width/2, h=height*1.5);

  translate([length - width, 0, 0]) {
    cylinder(r=width/2, h=height*1.5);
  }
}
