module arc(inner_r, wall, angle, align="inside") {
  abs_angle = abs(angle) % 360;
  dia = inner_r*2;

  // 360 degrees is 2𝜋 radians
  // x=5 cos 𝜃
  // y=5 sin 𝜃

  points = [
    [0, 0],
    for (i=[360:-90:abs_angle]) [(dia * cos(i)), dia * sin(i)],
    [dia * cos(abs_angle), dia * sin(abs_angle)]
  ];

  offset = align == "inside"
    ? 0
    : align == "outside"
    ? wall
    : align == "middle"
    ? wall/2
    : 0;

  difference() {
    circle(r=inner_r + wall - offset);

    circle(r=inner_r - offset);

    rotate([0, 0, abs_angle > angle ? angle : 0]) {
      polygon(points);
    }
  }
}
