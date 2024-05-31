include <support/vars.scad>
include <support/scale_to.scad>
include <support/roundedcube.scad>

width = 30;
height = 3;
ring = 1.5;
indent = 1;

outer_padding = 5;
inner_width = width - outer_padding;

$fn = $preview ? 30 : 100;

module svg(filename, viewbox=100) {
  // mm_dpi = 25.4; // Will make 100x image 100mm
  scale_factor = inner_width / viewbox;

  translate([-inner_width/2, -inner_width/2 + 1.5, 0])
  scale([scale_factor, scale_factor])
  import(str("/Users/rocco/code/scad/assets/coins/", filename, ".svg"), dpi=25.4);
}

module slime() {
  svg("slime/pupils", viewbox=100);
  difference() {
    svg("slime/body", viewbox=100);
    svg("slime/face", viewbox=100);
  }
}

module ghost() {
  svg("ghost/main", viewbox=24);
}

module prompt() {
  translate([0, -1.5, 0])
  svg("code/prompt", viewbox=100);
}

module img(filename) {
  heightmap = 100;
  img_size = 200;
  // expects a png- run `ruby assets/coins/svg_to_png.rb assets/coins/#{filename}.svg`
  // `surface` creates a heightmap using white=0, black=100
  scale_to(img_size, inner_width, [1, 1, 0])
  difference() {
    translate([-img_size/2, -img_size/2, -heightmap + height])
    surface(file=str("/Users/rocco/code/scad/assets/coins/", filename, ".png"));

    translate([-img_size/2 - 5, -img_size/2 - 5, -heightmap])
    cube([img_size+10, img_size+10, heightmap]);
  }
}

module coin() {
  difference() {
    cylinder(r=width/2, h=height);
    translate([0, 0, height-indent])
    cylinder(r=width/2 - ring, h=height);
  }
}

module coinicon() {
  coin();

  translate([0, 0, rerr])
  linear_extrude(height-rerr)
  children();
}

module heart() {
  radius = 6;
  module heart_sub_component() {
    rotated_angle = 45;
    diameter = radius * 2;
    $fn = 48;

    translate([-radius * cos(rotated_angle), 0, 0])
    rotate(-rotated_angle) union() {
      circle(radius);
      translate([0, -radius, 0])
      square(diameter);
    }
  }

  center_offset_y = (1.5 * radius * sin(45) - 0.5 * radius) - 1;

  translate([0, center_offset_y, 0]) union() {
    heart_sub_component();
    mirror([1, 0, 0]) heart_sub_component();
  }
}

module flower(petals) {
  module petal() {
    length = 1.2;
    width = 0.7;
    translate([15, 0, 0])
    scale([length, width, 1])
    circle(10);
  }

  petal_angles = 360/petals;
  scale(0.4)
  difference() {
    union() {
      for (angle = [0 : petal_angles : 360 - petal_angles]) {
        rotate(angle)
        petal();
      }
    }
    circle(8);
  }
}

coinicon()
// flower(7);
// heart();
// slime();
// ghost();
prompt();

w=15;
translate([-w/2, -w/2, rerr])
difference() {
  roundedcube([w, w, height]);
  translate([wall/2, wall/2, rerr])
  cube([w-wall, w-wall, height]);
}
