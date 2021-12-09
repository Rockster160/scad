// 2-3 cm x 3-8 cm x 6-12 cm

function cm(mm) = mm * 10;
function cm_to_in(cm) = cm / 2.54;
function cb_mm_to_in(cb_mm) = cb_mm * 16387;
function cb_mm_to_weight(cb_mm) = cb_mm_to_in(cb_mm) * 0.097544;

// # cube([cm(6), cm(3), cm(2)]);
// translate([0, cm(4), 0]) {
//   cube([cm(12), cm(8), cm(3)]);
// }

module ingot(w, d, h) {
  $fn = 60;
  r = 2; // Radius of curves
  xo = 2; // How much smaller top is
  yo = 3; // How much smaller top is

  difference() {
    hull() {
      translate([    r,     r,     r]) sphere(r=r);
      translate([    r, d - r,     r]) sphere(r=r);
      translate([w - r,     r,     r]) sphere(r=r);
      translate([w - r, d - r,     r]) sphere(r=r);

      translate([    r + xo,     r + yo, h - r]) sphere(r=r);
      translate([    r + xo, d - r - yo, h - r]) sphere(r=r);
      translate([w - r - xo,     r + yo, h - r]) sphere(r=r);
      translate([w - r - xo, d - r - yo, h - r]) sphere(r=r);
    }
    text_depth = 3;
    # translate([20, d/2 - 1.5, h+0.01 - text_depth]) rotate([0, 0, 90]) {
      linear_extrude(text_depth)
      text("Al", size=20, font="Gold", halign="center", valign="center");

      line_width = d - r - yo - 15;
      linear_extrude(text_depth)
      translate([-line_width/2 + 1.5, -15, 0])
      square([line_width, 2]);

      linear_extrude(text_depth)
      translate([0, -20, 0])
      text("0.95", size=6, font="Gold", halign="center", valign="center");

      linear_extrude(text_depth)
      translate([0, -(w - 50), 0])
      text("NET WT", size=6, font="Gold", halign="center", valign="center");

      linear_extrude(text_depth)
      translate([0, -(w - 40), 0])
      text("1 LB", size=6, font="Gold", halign="center", valign="center");
    }
  }
}

// ingot(cm(6), cm(3), cm(2));
color("#FFD700") {
  ingot(cm(12), cm(5.5), cm(3));
}
// ingot(cm(12), cm(8), cm(3));

// 31094   = 1.8974723
// 31124.3 = 1.899321318
