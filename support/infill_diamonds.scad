use <polyround.scad>

module infill_diamonds(x=1, y=1, w=10, h=20, s=1) {
  // x = Number of diamonds towards X direction
  // y = Number of diamonds towards Y direction
  // w = Width of each diamond
  // h = Height of each diamond
  // s = Space/padding between diamonds
  ws = w + s;
  hs = h + s;

  px = w/2;
  py = h/2;
  nx = -w/2;
  ny = -h/2;

  translate([(-ws/2) * (x-1), (-hs/2) * (y-1), 0]) {
    for (i=[0:x-1]) {
      for (j=[0:y-1]) {
        translate([i*ws, j*hs, 0])
        polygon(polyRound([
          [px, 0, 1],
          [0, py, 1],
          [nx, 0, 1],
          [0, ny, 1],
        ]));

        if (i < x-1 && j < y-1) {
          // Middles
          translate([i*ws + ws/2, j*hs + hs/2, 0])
          polygon(polyRound([
            [px, 0, 1],
            [0, py, 1],
            [nx, 0, 1],
            [0, ny, 1],
          ]));
        }

        if (i == 0) {
          // Left side
          if (j == 0) {
            // Bottom row
            translate([-ws/2, -hs/2, 0])
            polygon(polyRound([
              [px, 0, 1],
              [0, py, 1],
              [0, 0, 1],
            ]));
          }
          if (j < y-1) {
            // Middle Rows
            translate([-ws/2, j*hs + hs/2, 0])
            polygon(polyRound([
              [px, 0, 1],
              [0, py, 1],
              [0, ny, 1],
              ]));
          } else if (j == y-1) {
            // Top Row
            translate([-ws/2, j*hs + hs/2, 0])
            polygon(polyRound([
              [0, 0, 1],
              [px, 0, 1],
              [0, ny, 1],
            ]));
          }
        }
        if (i == x-1) {
          // Right Side
          if (j == 0) {
            // Bottom row
            translate([i*ws + ws/2, -hs/2, 0])
            polygon(polyRound([
              [nx, 0, 1],
              [0, py, 1],
              [0, 0, 1],
            ]));
          }
          if (j < y-1) {
            // Middle Rows
            translate([i*ws + ws/2, j*hs + hs/2, 0])
            polygon(polyRound([
              [nx, 0, 1],
              [0, ny, 1],
              [0, py, 1],
            ]));
          } else if (j == y-1) {
            // Top Row
            translate([i*ws + ws/2, j*hs + hs/2, 0])
            polygon(polyRound([
              [0, 0, 1],
              [nx, 0, 1],
              [0, ny, 1],
            ]));
          }
        }
        if (j == 0 && i < x-1) {
          // Bottom Row Middles
          translate([i*ws + ws/2, -hs/2, 0])
          polygon(polyRound([
            [px, 0, 1],
            [nx, 0, 1],
            [0, py, 1],
          ]));
        }
        if (j == y-1 && i < x-1) {
          // Top Row Middles
          translate([i*ws + ws/2, j*hs + hs/2, 0])
          polygon(polyRound([
            [px, 0, 1],
            [nx, 0, 1],
            [0, ny, 1],
          ]));
        }
      }
    }
  }
}
