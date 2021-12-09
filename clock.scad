//Animate:
//FPS=60
//Steps=2400000
around=360;
hour=1;
minute=12;
second=720;
//clock disc
color("powderblue")
linear_extrude(height=2.5){
	circle(d=65,$fn=128);}
//numbers
color("steelblue")
linear_extrude(height=2.0){
	rotate(42){
			for(j=[1:12])
				//if single digit, adjust by 5 degrees
			if (j>9)
			{
					rotate(-j*30 - 30)
						translate([33,0])
							rotate(-100)
								offset(r=.5)
									text(str(j));
			}
			else
			{
					rotate(-j*30 - 35)
						translate([33,0])
							rotate(-100)
								offset(r=.5)
									text(str(j));
			}
	}
}
//second hand
color("CadetBlue")
	linear_extrude(height=3.25){
		circle(d=2,$fn=32);
		rotate(-around*second*$t)
			hull(){
				translate([28,0,0])rotate(0)scale([.75,1,1])circle(d=1,$fn=3);
				translate([0,0,0])rotate(180)scale([1,1,1])circle(d=1,$fn=3);
			}
	}
//markers, minute and hour hands
color("CornflowerBlue")
	linear_extrude(height=3){
		circle(d=5,$fn=32); //center dot
//hour hand
rotate(-around*hour*$t)
	hull(){
		translate([20,0,0])rotate(0)scale([.75,1,1])circle(d=6,$fn=3);
		translate([0,0,0])rotate(180)scale([1,1,1])circle(d=2,$fn=3);
	}
	//minute hand
rotate(-around*minute*$t)
	hull(){
		translate([27,0,0])rotate(0)scale([.75,1,1])circle(d=4,$fn=3);
		translate([0,0,0])rotate(180)scale([1,1,1])circle(d=1,$fn=3);
	}
//markers:
for(i=[0:11])  //hours=dots
	rotate(i*30)
		translate([30,0,0])
			circle(d=2.5,$fn=32);
for(i=[0:11]) //minutes=dashes
	rotate(i*30){
		rotate(6)
			for(i=[0:3])
				rotate(i*6)
					translate([29,0,0])
						square([2,.4]);
	}
}
