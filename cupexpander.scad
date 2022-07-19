include <support/vars.scad>

dep = 50;
wr = 65/2;
or = 100/2;
h = 40;
wall = wall_size("weak");

cylinder(r=wr, h=dep);

angled_height = ((or + wall*2) - wr) * cos(50);
translate([0, 0, dep-rerr])
cylinder(angled_height, wr, (or + wall*2));

translate([0, 0, dep + angled_height - rerr]) {
  difference() {
    cylinder(r=or + wall*2, h=h);

    translate([0, 0, rerr])
    cylinder(r=or, h=h);

    translate([wr/2, -h/2, rerr])
    # cube(h);
  }
}
