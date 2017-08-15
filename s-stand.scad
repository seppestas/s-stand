module s_stand_shape(depth, height, r, w) {
	module side(height, r, w) {
		module half_side(height, r, w) {
			translate([0,height-r,0])
			union() {
				intersection() {
					square(r);
					difference() {
						circle(r);
						circle(r-w);
					}
				}
				translate([r-w,-(height-r),0]) {
					square([w, height-r]);
				}
			}
		}

		half_side(height/2, r,w);
		mirror([0,1,0]) half_side(height/2, r,w);
	}

	union() {
		side_height = height/2+w/2;

		translate([r,(height-w),0]) square([depth, w]);
		translate([r,(height+w)*3/4-w,0]) mirror([1, 0, 0]) side(side_height, r, w);
		translate([r,(height-w)/2,0]) square([depth-r, w]);
		translate([depth,(height+w)*1/4,0]) side(side_height, r, w);
		square([depth, w]);
	}
}

module s_stand(width, depth, height, r=30, w=10) {
	linear_extrude(width) s_stand_shape(depth, height, r, w);
}
