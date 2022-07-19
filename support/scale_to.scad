// From is original size
// To is desired size
// cardinals is [x, y, z]
// 0 to skip that direction, 1 to apply in that direction
module scale_to(from, to, cardinals) {
	// Scale: desired / current
	scale_val = to / from;
	scalex = cardinals.x == 0 ? 1 : scale_val * cardinals.x;
	scaley = cardinals.y == 0 ? 1 : scale_val * cardinals.y;
	scalez = cardinals.z == 0 ? 1 : scale_val * cardinals.z;
	scale([scalex, scaley, scalez])
	children();
}
