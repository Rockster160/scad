// INCOMPLETE

// ===== Normal Variables
// # of short side "units" [ct]
x_buckets = 2;
// # of long side "units" [ct]
y_buckets = 2;
// wall thickness [#mm]
outer_wall = 4;
inner_wall = 1;
// # of subdivision "buckets" across short side [ct]
x_subs = 2;
// # of subdivision "buckets" across long side [ct]
y_subs = 2;
// tolerance [#mm]
tol = 0.5;
// label [yes/no]
label = true; // true/false
// label position [short unit side/long unit side]
label_side = "x"; // x/y
// label height [#mm] (defines from the start of the label angle area to the bottom. e.g. the label tape is 6mm so might select 7mm as the height)
label_height = 7;
// label text [abcd123!@&]
label_text = "abcd123!@&";
// label text size [?]
label_text_size = 6;
// label angle [#degrees]
label_angle = 60;
// rim [#mm]
// rim = 5; // -- ?
// corners [#mm] (blank = normal corner, mm defines the corner length at top edge)
// corners = 5; // -- ?

// ===== Configuration (Probably just set these once ever)
division_w = 70; // This is the OUTSIDE long measurement of 1 box
division_d = 50; // This is the OUTSIDE short measurement of 1 box
division_h = 30; // This is the OUTSIDE height of 1 box

// ====== A
rerr = 0.01;

module box(w, d, h, wall) {
  difference() {
    cube([w, d, h]);

    translate([wall, wall, wall+rerr])
    cube([w-(wall*2), d-(wall*2), h]);
  }

  rotate([0, 0, 45])
  # cube([w, d, h]);
}


box(division_w, division_d, division_h, outer_wall);
