include <support/threads.scad>
include <support/polyround.scad>

$fn = 100;

tolerance = 0.4;
wall = 4;
rerr = 0.01;

function in_to_mm(in) = in * 25.4;
function inner_to_outer(id) = id - wall*2 - tolerance*4;

converter_angle = 30; // Max angle, generally matches the angle your print can tower at without support.

skill_saw = 35.3;
table_saw = 64;
miter_saw = 64.2;
sander = 63.7;
yellow_vac = 40.7;
shop_vac_outer_d = 57.75; // OD
shop_vac = inner_to_outer(shop_vac_outer_d);

universal_adapter_f = 65;
universal_adapter_m = universal_adapter_f - wall*2 - tolerance*2;

hose = in_to_mm(2.5);
h = in_to_mm(1);

// Miter needs a lift from bottom 1/3?

// hose_thread_majord = 73;
// hose_thread_minord = 60;
hose_thread_majord = 70;
hose_thread_minord = 63;
hose_thread_pitch = 10;
hose_adaptor_h = h*1.5;
// HOSE
// {
//   69.8 // Thread OD
//   60 // Plastic OD
//   6 // Thread spacing (Pitch)
//   7 // Thread width
//   ~ 3.5 // Threads per inch
// }

module outer_connector(size, height=h) {
  difference() {
    cylinder(r=size/2 + tolerance + wall, h=height);

    translate([0, 0, -rerr])
    cylinder(r=size/2 + tolerance, h=height + rerr*2);
  }
}

module adapter_tube(d1, d2, height=h) {
  difference() {
    cylinder(height, d1/2 + tolerance + wall, d2/2 + tolerance + wall);

    translate([0, 0, -rerr])
    cylinder(height + rerr*2, d1/2 + tolerance, d2/2 + tolerance);
  }
}

module threaded_hose_adapter() {
  difference() {
    cylinder(r=hose_thread_majord/2 + wall + tolerance, h=hose_adaptor_h);

    translate([0, 0, -rerr])
    mirror([1, 1, 0])
    metric_thread(hose_thread_majord, hose_thread_pitch, hose_adaptor_h + rerr*2, internal=true);
  }
}

module adapter(od1, od2, offset_h=h, include_base=true) {
  s1 = od1 > od2 ? od1 : od2;
  s2 = od1 > od2 ? od2 : od1;

  if (include_base) {
    outer_connector(s1);
  }

  angled_height = (s1 - s2) * cos(converter_angle);
  translate([0, 0, offset_h - rerr])
  adapter_tube(s1, s2, angled_height);

  translate([0, 0, offset_h + angled_height - rerr*2])
  outer_connector(s2);
}

module hose_to_vac() {
  threaded_hose_adapter();

  adapter(hose_thread_majord, shop_vac, offset_h=hose_adaptor_h, include_base=false);
}

module hose_to_adapter() {
  threaded_hose_adapter();

  adapter(hose_thread_majord, universal_adapter_f, offset_h=hose_adaptor_h, include_base=false);
}

module uni_to_size(size) {
  adapter(universal_adapter_m, size);
}

// outer_connector(skill_saw, height=5);
// outer_connector(table_saw, height=5);
// outer_connector(sander, height=5);
// outer_connector(40);

module oval(o=0) {
  nw = 40/2;
  nh = 20/2;

  polygon(polyRound([
    [-nw + o,      -nh + o, 10],
    [nw - o,       -nh + o, 10],
    [nw + nh - o,  0,       10],
    [nw - o,       nh - o,  10],
    [-nw + o,      nh - o,  10],
    [-nh - nw + o, 0,       10],
  ]));
}

module nozzle_tube() {
  difference() {
    oval();

    oval(wall);
  }
}

module nozzle(tube_height) {
  difference() {
    uni_to_size(0);

    linear_extrude(150)
    oval();
  }

  difference() {
    translate([0, 0, h + rerr])
    linear_extrude(tube_height)
    nozzle_tube();

    angled_height = universal_adapter_m * cos(converter_angle);
    translate([0, 0, h])
    cylinder(angled_height + rerr*2, universal_adapter_m/2 + tolerance, tolerance);
  }

  bend_h = 45;
  nw = 40; // (Taken from above)
  nh = 20; // (Taken from above)
  angle_fix_y = 1.3;
  angle_fix_z = 5;

  difference() {
    translate([0, angle_fix_y, tube_height + h - angle_fix_z])
    rotate([15, 0, 0])
    linear_extrude(bend_h)
    nozzle_tube();

    translate([0, 0, tube_height + h - bend_h])
    linear_extrude(bend_h)
    oval(wall);

    // Hard coding offsets to save time
    w = nw + wall*4;
    # translate([-w/2, -68, tube_height + h + 10])
    rotate([-20, 0, 0])
    cube([w, w, w]);
  }
}

module pointer(height=150) {
  # outer_connector(universal_adapter_m, 40);

  difference() {
    // Scale: desired / current
    // (current - offset) / current
    scale_val = (universal_adapter_m - wall) / universal_adapter_m;
    cylinder(universal_adapter_m, universal_adapter_m/2, 10, center=false);

    translate([0, 0, -rerr])
    scale([scale_val, scale_val, 1.1]) {
      cylinder(universal_adapter_m, universal_adapter_m/2, 10, center=false);
    }
  }

//   adapter(universal_adapter_m, 10, 40, false);
}

// pointer();

nozzle(150);


// uni_to_size(skill_saw);
// uni_to_size(miter_saw);
// uni_to_size(table_saw);
// difference() {
//   uni_to_size(sander);
//   cube([3, 80, 5], center=true);
// }

// hose_to_vac(); // Complete
// hose_to_adapter(); // Complete
