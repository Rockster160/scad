// Outside corner
module chamfer(radius=1, depth=1, $fn=20) {
	translate([0, 0, -0.01])
	linear_extrude(depth + 0.02)
	difference() {
		translate([-radius - 0.01, -radius - 0.01, 0.01])
		square(radius*2);

		translate([radius - 0.01, radius - 0.01, 0.01])
		circle(radius);
	}
}

// inside corner
// mitre fillet - sharp edge
// convex fillet - outside round
// concave fillet - inside round (below)
module fillet(radius, depth, $fn=20) {
	linear_extrude(depth) 
	translate([-0.01, -0.01, 0])
	difference() {
		square(radius);

		translate([radius, radius, 0])
		circle(radius);
	}
}
