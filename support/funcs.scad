function calc_diag(w, d) = sqrt(pow(w, 2) + pow(d, 2));;
function dist(point1, point2=[0,0,0]) = sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2) + pow(point2.z - point1.z, 2));
function has(list, item) = len(search(list, item)) > 0;
