BEVEL = 2;
LEG = 25;
H = 60;
LIP_W = 8+BEVEL;
LIP_H = 2;
OLIP_H = 20;
OLIP_W = 2;
IR = 3;
OFN = 96;

OR = 2 + LEG*0.414 + (IR+BEVEL) - BEVEL*1.414;

module corner(h,or) {
    translate([-LEG, -LEG, 0])
	cylinder (r=or+LEG, h=h, $fn=OFN);
}

module whole() {
    color("skyblue")
    difference() {
	intersection() {
	    union () {
		corner (H, OR);
		corner (LIP_H, OR+LIP_W);
		difference() {
		    translate([-LEG, -LEG, 0])
			cylinder (r=OR+LEG+LIP_W, h=OLIP_H, $fn=OFN);
		    translate([-LEG, -LEG, -1])
			cylinder (r1=OR+LEG+LIP_W-OLIP_W, r2=OR+LEG+LIP_W-0.1, h=OLIP_H+2, $fn=OFN);
		}
	    }
	    translate([-LEG, -LEG, -1])
		cube([1000, 1000, 1000]);
	}
	translate([-BEVEL, -BEVEL, -1])
	    cylinder (r=IR+BEVEL, h=H+2, $fn=24);
	translate([-1000, -1000, -1])
	    cube([1000, 1000, H+2]);
    }
}

*whole();
minkowski() {
    whole();
    intersection() {
        sphere(r=BEVEL, $fn=30);
        cube([BEVEL*10, BEVEL*10, BEVEL*1.4], center=true);
    }
}
