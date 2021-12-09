include <support/linepath.scad>
include <support/roundedcube.scad>
function in_to_mm(in) = in * 25.4;

rerr = 0.01;
rerr2 = rerr*2;

w = in_to_mm(3.5); // = 88.9
d = in_to_mm(2 + 13/16); // = 71.4375
h = 23.4;

l1h = 9.8;
l2h = 6.6;
l3h = 7;

l2d = 55;
l3d = 46;

back = 12.8;

// % cube([w, d, h]);

module layer1() {
  cube([w, d, l1h]);
}

module layer2_slot() {
  translate([back, (d - l2d)/2, l1h-rerr]) {
    cube([w, l2d, l2h + rerr2]);

  }
//   translate([0, 0, l1h]){
//     difference() {
//       cube([w, d, l2h]);
//
//       wall_d = 8;
//       translate([back, wall_d, -rerr])
//       cube([w, d - wall_d*2, l2h + rerr2]);
//     }
//   }
}

module layer3_slot() {
  slide_d = (d - l3d)/2;

  translate([0, 0, l1h + l2h - rerr]) {
    translate([back, slide_d, 0]) {
      cube([w, l3d, l3h + rerr2]);
    }

    clip_d = 53;
    clip_w = 6;
    translate([w - clip_w + rerr, (d - clip_d)/2, -rerr])
    cube([clip_w, clip_d, l3h + rerr2]);

    snap_ex_d = 62;
    snap_cl_d = 53;
    snap_pt_w = 1.5;
    snap_w = 10;
    snap_tri_d = 5.5;

    translate([w-clip_w+rerr2, (d - snap_ex_d)/2, 0])
    linear_extrude(l3h + rerr2)
    mirror([1, 0, 0])
    polygon([
      [0, 0],
      [snap_pt_w, 0],
      [snap_w, snap_tri_d],
      [snap_w, snap_ex_d - snap_tri_d],
      [snap_pt_w, snap_ex_d],
      [0, snap_ex_d],
      [0, 0],
    ]);
  }
//   translate([0, 0, l1h + l2h]){
//     difference() {
//       cube([w, d, l3h]);
//
//       slide = 12.6;
//       translate([back, slide, -rerr])
//       cube([w - back + rerr, d - slide*2, l3h + rerr2]);
//
// -----
//       clip_d = 9;
//       clip_w = 5.5;
//       translate([w - clip_w + rerr, clip_d, -rerr])
//       cube([clip_w, d - clip_d*2, l3h + rerr2]);
//
//       t_w = 10.3213371;
//       t_h = 4.6;
//       translate([w - t_w - clip_w + rerr2, d - slide - rerr, -rerr ])
//       linear_extrude(l3h + rerr2)
//       polygon([[0,0], [t_w, 0], [t_w, t_h]]);
//
//       translate([w - t_w - clip_w + rerr2, slide+rerr, -rerr ])
//       linear_extrude(l3h + rerr2)
//       polygon([[0,0], [t_w, -t_h], [t_w, 0]]);
//     }
//   }
}

difference() {
  roundedcube([w, d, h], radius=1);

  layer2_slot();
  layer3_slot();
  
  color("red")
  translate([back * (1/2), d * (2/3), h]) {
    cube([3, 10, 1], center=true);
    cube([10, 3, 1], center=true);
  }

  color("black")
  translate([back * (1/2), d * (1/3), h]) {
    cube([3, 10, 1], center=true);
  }
}
// layer1();
// layer2();
// difference() {
//   layer3();
//
// }
//
