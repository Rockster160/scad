// Make better ESP box and cutout (using upside down style)

include <support/scale_to.scad>
include <btn_cap.scad>

// https://thenounproject.com/

files_dpis = [
  // Desk
  ["pill", -1],
  ["water", 4],
  ["can", 8.5],
  ["protein", 1],
  // Kitchen
  ["bread", 8],
  ["butter", -6],
  ["egg", 4],
  ["cheese", 2],
  ["milk", 1],
  // Bathroom
  ["tooth", 0],
  ["sleep", 5],
  ["shower", 1],
];
map_scale = 1000;

height = blue_actuation_space + ou_out_h + 2;


col_count = ceil(sqrt(len(files_dpis)));

for (i=[0:len(files_dpis)-1]) {
  translate([17*floor(i/col_count), 17*(i%col_count), 0]) {
    if (files_dpis[i].x) {
      rgb(50, 50, 50) translate([15/2, 15/2, height-tol]) linear_extrude(2) {
        scaled = (map_scale - (files_dpis[i].y * 50)) / map_scale;
        //scaled = files_dpis[i].y/map_scale;
        scale([1/map_scale, 1/map_scale, 1])
        offset(0.001)
        import(str("/Users/rocco/code/scad/assets/buttons/", files_dpis[i].x, ".svg"), dpi=scaled, center=true);
      }
      translate([15/2, 15/2, 0])
      color("white")
      keycap();
    }
  }
}
