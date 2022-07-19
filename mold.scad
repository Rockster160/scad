linear_extrude(10) circle(10);
// include <support/in_to_mm.scad>
//
// $fn = 200;
//
// // PVC pipe is measured in ID - 4" pipe has 4" inner diameter
//
// // tube_size = in_to_mm(3);
// // sphere_size = in_to_mm(2.75);
// tube_size = in_to_mm(4);
// sphere_size = in_to_mm(3.5);
//
// wall = 4;
//
// p_tol = 1; // Print tolerance
// r_tol = 1; // Real item tolerance
//
// full_w = (tube_size - r_tol);
// h = sphere_size/2 + wall;
//
//
// difference() {
//   cylinder(r=full_w/2, h=h);
//
//   offset = sphere_size/2 + wall;
//   translate([0, 0, wall + sphere_size/2])
//   sphere(sphere_size/2);
// }
//
