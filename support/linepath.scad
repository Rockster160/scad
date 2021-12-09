module line(start, end, thickness = 1) {
  hull() {
    translate(start) circle(thickness);
    translate(end) circle(thickness);
  }
}

module path(line_points, thickness = 1) {
  for (i=[0:len(line_points)-1]) {
    if (i > 0) {
      line(line_points[i-1], line_points[i], thickness);
    }
  }
}

// line([40, 10, 0], [70, 70, 0])
// path([40, 10, 0], [70, 70, 0], [100, 100, 0])
// path can take multiple arguments- including the return of PolyRound (Only supports 2d lines)
