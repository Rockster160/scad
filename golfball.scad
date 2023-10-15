$fn=100;

golfball_d = 42.7;
wall = 4;

difference() {
  sphere(r=golfball_d/2);
  sphere(r=(golfball_d/2)-(wall/2));
}
