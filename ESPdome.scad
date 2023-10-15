include <support/vars.scad>
include <support/scale_to.scad>
include <esp.scad>

wall = wall_size("flimsy");
tol = tolerance("loose");

inner_dome = 80;
led_w = 5.5;
btn_slot = 16.1;
$fn=60;

clip_wall = wall_size("weak");
clip_width = 5;
clip_clip = 1;
clip_h = bat_h + clip_clip;

dome_wall = inner_dome + (wall*2);

module dome() {
  difference() {
    sphere(r=dome_wall/2);
    sphere(r=inner_dome/2);

    translate([-dome_wall/2, -dome_wall/2, -dome_wall])
    cube([dome_wall, dome_wall, dome_wall]);

    translate([btn_slot, 0, dome_wall/2])
    cylinder(r=led_w/2, h=dome_wall, center=true);

    translate([0, 0, dome_wall/2])
    cylinder(r=btn_slot/2, h=dome_wall, center=true);
  }
}

module clip() {
  translate([0, -clip_wall/2, -0.01]) {
    translate([-clip_width/2, clip_wall/2 - 0.01, clip_h])
    rotate([0, 90, 0])
    linear_extrude(clip_width)
    polygon([
      [clip_clip, 0],
      [0, clip_clip],
      [-clip_clip, 0]
    ]);

    translate([clip_width/2, -clip_wall/2 + 0.02, 0])
    rotate([90, 0, -90])
    linear_extrude(clip_width)
    #polygon([
      [0, clip_h],
      [clip_wall, 0],
      [0, 0]
    ]);

    translate([-clip_width/2, -clip_wall/2, 0])
    cube([clip_width, clip_wall, clip_h + clip_clip]);
  }
}

module clips() {
  translate([0, 0, wall-0.02]) {
    translate([0, -bat_w/2, 0])
    clip();

    translate([0, bat_w/2, 0])
    rotate([0, 0, 180])
    clip();

    translate([bat_d/2, 0, 0])
    rotate([0, 0, 90])
    clip();

    translate([-bat_d/2, 0, 0])
    rotate([0, 0, 270])
    clip();
  }
}

module dome_plate() {
  difference() {
    linear_extrude(wall)
    circle(r=(dome_wall + wall)/2);

    scale_to(dome_wall, dome_wall+tol/2, [1, 1, 1])
    translate([0, 0, wall/2])
    dome();
  }
  clips();
}
// translate([-bat_d/2, -bat_w/2, wall])
// cube([bat_d, bat_w, bat_h]);

// translate([dome_wall + 2, 0, 0])
#dome();
// dome_plate();

translate([0, 0, bat_h])
espAndShield(center = true);
translate([0, 0, dome_wall/2 - wall/2])
button();

battery();
