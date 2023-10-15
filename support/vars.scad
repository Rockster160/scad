// Used to merge objects on the same coord
rerr = 0.01;
rerr2 = rerr*2;

// Typically recommended to use nozzle size as tolerance to get two pieces to fit together tightly
tolerances = [
  ["perfect",  0.1],
  ["precise",  0.2],
  ["tight",    0.3],
  ["friction", 0.4],
  ["loose",    0.5],
  ["near",     0.6],
];
function tolerance(key) = tolerances[search([key], tolerances)[0]][1];

wall_sizes = [
  ["paper",    1],
  ["flimsy",   2],
  ["weak",     3],
  ["strong",   4],
  ["stronger", 5],
  ["solid",    6],
];
function wall_size(key) = wall_sizes[search([key], wall_sizes)[0]][1];

// Defaults (Can be overridden)
wall = wall_size("flimsy");
tol = tolerance("loose");
