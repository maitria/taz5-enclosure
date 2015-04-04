
module u_bracket(cable_diameter, screw_head_height, screw_head_diameter) {
  width = screw_head_diameter + 2 * screw_head_height;
  difference() {
    union() {
      translate([0, 0, cable_diameter/2]) rotate([-90, 0, 0]) cylinder(d = cable_diameter + 2 * screw_head_height, h = width);
      translate([-cable_diameter/2 - screw_head_height, 0, 0]) cube([cable_diameter + 2 * screw_head_height, width, cable_diameter/2]);
      translate([-(4 * screw_head_height + cable_diameter + screw_head_diameter)/2, 0, 0]) cube([4 * screw_head_height + cable_diameter + screw_head_diameter, width, screw_head_height]);
    }
    translate([0, -0.5, cable_diameter/2]) rotate([-90, 0, 0]) cylinder(d = cable_diameter, h = 1 + width);
    translate([-cable_diameter/2, -0.5, -1]) cube([cable_diameter, 1 + width, cable_diameter/2 + 1]);
    translate([-cable_diameter/2 - screw_head_height, -0.5, -(1 + screw_head_height)]) cube([cable_diameter + 2 * screw_head_height, 1 + width, 1 + screw_head_height]);
  }
}

u_bracket(cable_diameter = 11, screw_head_height = 4, screw_head_diameter = 9);
