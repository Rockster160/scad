use <roundedcube.scad>

module centeredcube(size) {
  translate([-size.x/2, -size.y/2, 0])
  roundedcube([size.x, size.y, size.z]);
}
