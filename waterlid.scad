// $fn = 30;
$fn = 100;

t = 0.5;
rerr = 0.01;

wall = 3;
base = 9;

inner = 62.5 + t;
hole = 6.5 + t;
h = 20.5;
roundness = 4;

// minkowski() {
//   cylinder(r=inner/2 + wall, h=base);
//
//   sphere(1);
// }


// module trim() {
// }
// trim();

// translate([inner/2 + wall*2, 0, 0])
// # cube([10, 10, base + h]);
//
// translate([5, 0, base])
// # cube([5, 5, h]);
//
// translate([0, 0, 0])
// # cube([2, 2, base]);

difference() {
  minkowski() {
    translate([0, 0, roundness])
    cylinder(r=inner/2 + wall, h=h+base - roundness*2);

    sphere(roundness);
  }
//   cylinder(r=inner/2 + wall, h=h+base);

  translate([0, 0, base])
  cylinder(r=inner/2, h=h+base);

  translate([0, 0, -1])
  cylinder(r=hole/2, h=base*2);

  chars = "Stacy + Rocco";

  PI = 3.14159265358979323846264338327950288;
  chars_per_circle = 30;
  radius = inner/2 + wall/2 + 2;
  step_angle = (360 / chars_per_circle) - 2;
  circumference = 2 * PI * radius;
  char_size = circumference / chars_per_circle;
  char_thickness = 2;

  for(i = [0 : chars_per_circle - 1]) {
    rotate(i * step_angle)
    translate([0, radius + char_size / 2, (base+h)/2 + char_size/2 - 1])
    # mirror() rotate([90, 180, 0]) linear_extrude(char_thickness) text(
      chars[chars_per_circle - i - 1],
      font = "Courier New; Style = Bold",
      size = char_size,
      halign = "center"
    );
  }
}
