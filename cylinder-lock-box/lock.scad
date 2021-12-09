$fn = 100;

secret = [2, 3, 1, 2];

module base() {
    
    difference() {
        union() {
            cylinder(30, 12, 12);
            
            translate([0, 0, 28])
            cylinder(2, 12, 13);
        }
        
        translate([0, 0, -1])
        cylinder(32, 10.1, 10.1);
        
        for (i = [0: 3]) {
            translate([-2, 0, 5 + i * 6])
            rotate([0, -90, 0])
            cylinder(10, 2.2, 2.2);
        }
        
        translate([0, -2.6, 24])
        cube([20, 20, 10]);
        
    }
    
    difference() {
        translate([-5, 12.5, 0])
        cube([47.9, 62.9, 4], true);
        
        translate([0, 0, -3])
        cylinder(6, 9, 9);
        
        cylinder(6, 10.1, 10.1);
    }
    
    translate([-14, 30, 0])
    difference() {
        translate([-2, -2, 0])
        cube([9, 10, 28]);
        
        translate([0, -30, -1])
        linear_extrude(32)
        offset(0.1)
        projection()
        springs();
    }
    
    translate([13.9, 38.9, 0])
    cube([4, 4, 10]);
    
    translate([-27.9, -17.9, 0])
    cube([4, 4, 10]);
    
    translate([-27.9, 38.9, 0])
    cube([4, 4, 10]);
    
    translate([13.9, -17.9, 0])
    cube([4, 4, 10]);
}

module springs() {
    for (i = [0: 3]) {
        translate([0, 0, i * 6])
        spring();
    }
    
    translate([0, 30, -2])
    cube([2, 5, 22]);
    
    translate([0, 32, -2])
    cube([5, 2, 22]);
}

module spring() {
    translate([0, 0, -2])
    cube([2, 30, 4]);
    rotate([0, 90, 0])
    spring_pin();
}

module spring_pin() {
    cylinder(7, 1.5, 1.5);
    cylinder(2, 2, 2);
    
    translate([0, 0, 7])
    cylinder(0.5, 1.5, 0.5);
}

module stop_ring() {
    rotate([0, 0, -10])
    difference() {
        cylinder(5, 16, 16);
        
        translate([0, 0, -0.01])
        cylinder(3, 12.1, 12.1);
        
        translate([0, 0, 1.01])
        cylinder(2, 12.1, 13.1);
        
        
        translate([0, 0, -1])
        cylinder(7, 8, 8);
        
        translate([-5, -5, -1])
        cube([25, 25, 7]);
    }
}


module plug() {
    difference() {
        cylinder(30, 10, 10);
        
        translate([2, -1, -1])
        cube([4, 4, 32]);
        
        translate([-6, -1, -1])
        cube([9, 2, 32]);
        
        for (i = [0: 3]) {
            translate([0, 0, 5 + i * 6])
            rotate([0, -90, 0])
            cylinder(10, 2.2, 2.2);
        }    
    }
    
    rotate([0, 0, -90])
    translate([0, 12, 28])
    cube([5, 8, 4], true);
}

function blade(v, x) = 
    x < len(secret) 
        ? concat(ridge(x), blade(v, x + 1))
        : v;

function ridge(x) = [
    [x * 6, 2 + secret[x]],
    [x * 6 + 2, 2 + secret[x]],
    [x * 6 + 4, 2 + secret[x] - 1],
];

module key() {
    mirror([0, 0, 1]) {
        translate([2.1, -0.9, -1])
        difference() {
            cube([3.8, 3.8, 31]);
            
            translate([-2.5, 0, -1])
            rotate([0, 50, 0])
            cube([3, 5, 3]);
            
            translate([2.5, 0, -1])
            rotate([0, 40, 0])
            cube([3, 5, 3]);
            
            translate([-1, -1.7, -4.2])
            rotate([55, 0, 0])
            cube([5, 5, 3]);
            
            translate([-1, 3.8, -4])
            rotate([50, 0, 0])
            cube([5, 5, 3]);
        }
        
        // key blade
        translate([1, 0.9, 4])
        rotate([0, 0, 90])
        rotate([0, -90, 0])
        linear_extrude(1.8)
        polygon(concat([[-4, -2]], blade([], 0), [[26, 5], [26, -2]]));
        
        // head
        
        translate([0, 2.9, 0])
        rotate([90, 0, 0])
        difference() {
            linear_extrude(3.8)
            offset(2)
            polygon([
                [-10, 33], [-6, 33], [-6, 30], [5, 30],
                [5, 33], [12, 33], [10, 47], [-8, 47]
            ]);
            
            
            translate([0, 0, -0.1])
            linear_extrude(4)
            offset(2)
            polygon([
                [5, 44], [-3, 44], [-4, 43], [6, 43]
            ]);
            
        }
    }
}

module pins() {
    for (i = [0: len(secret) - 1]) {
        translate([-6.8, 0, i * 6 - 18])
        rotate([0, 90, 0])
        pin(secret[i]);
    }
}

module pin(h) {
    cylinder(h + 3.8, 2, 2);
    
    translate([0, 0, h + 3.8])
    cylinder(0.5, 2, 1);
    
    translate([0, 0, -0.5])
    cylinder(0.5, 1, 2);
    
}

module box() {
    difference() {
        cube([50, 65, 60]);
        
        translate([2, 2, -1])
        cube([46, 61, 59]);
        
        translate([1, 1, -1])
        cube([48, 63, 3]);
    }
    
    translate([44, 17, 22.5])
    box_shelf();
    
    
}

module box_shelf() {
    cube([5, 13, 3]);
    
    rotate([90, 0, 0])
    linear_extrude(3)
    polygon([[0, 0], [4, 0], [4, 9], [0, 4]]);
    
    translate([0, 16, 0])
    rotate([90, 0, 0])
    linear_extrude(3)
    polygon([[0, 0], [4, 0], [4, 9], [0, 4]]);
}


module preview() {
    difference() {
        union() {
            plug(); // *** print ***
            base(); // *** print ***

            translate([-14, 0, 5])
            springs(); // *** print ***

            translate([0, 0, 27])
            stop_ring(); // *** print ***
            
        }
        translate([-40, -40, -3])
        cube([100, 40, 50]);
    }

    translate([-2.55, 0, 23])
    pins(); // *** print ***

    translate([0, 0, 28])
    key(); // *** print ***

    difference() {
        translate([-30, -20, 0])
        box(); // *** print ***
        
        translate([-40, -40, -3])
        cube([50, 70, 50]);
    }
}

preview();