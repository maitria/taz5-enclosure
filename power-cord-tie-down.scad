
module u_bracket(cable_diameter, thickness = 4, screw_head_diameter = 9) {
	width = screw_head_diameter + 2 * thickness;
	difference() {
		union() {
			translate([0, 0, cable_diameter/2]) rotate([-90, 0, 0]) cylinder(d = cable_diameter + 2 * thickness, h = width);
			translate([-cable_diameter/2 - thickness, 0, 0]) cube([cable_diameter + 2 * thickness, width, cable_diameter/2]);
			translate([-(4 * thickness + cable_diameter + screw_head_diameter)/2, 0, 0]) cube([4 * thickness + cable_diameter + screw_head_diameter, width, thickness]);
		}
		translate([0, -0.5, cable_diameter/2]) rotate([-90, 0, 0]) cylinder(d = cable_diameter, h = 1 + width);
		translate([-cable_diameter/2, -0.5, -1]) cube([cable_diameter, 1 + width, cable_diameter/2 + 1]);
		translate([-cable_diameter/2 - thickness, -0.5, -(1 + thickness)]) cube([cable_diameter + 2 * thickness, 1 + width, 1 + thickness]);
	}
}

u_bracket(cable_diameter = 11);
