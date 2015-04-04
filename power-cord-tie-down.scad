smidge = 0.5;

module outer_ring(cable_diameter, screw_head_height, width) {
  wall_height = cable_diameter/2;
  outside_diameter = cable_diameter + (2 * screw_head_height);
  translate([0, 0, wall_height]) rotate([-90, 0, 0]) 
    cylinder(d = outside_diameter, h = width);
}

module ring_hole(cable_diameter, screw_head_height, width) {
  wall_height = cable_diameter/2;
  translate([0, -smidge, wall_height]) rotate([-90, 0, 0]) 
    cylinder(d = cable_diameter, h = 2*smidge + width);
}

module open_bottom_of_ring(cable_diameter, screw_head_height, width) {
  translate([-cable_diameter/2 - screw_head_height, -smidge, -(smidge + screw_head_height)]) 
    cube([cable_diameter + 2 * screw_head_height, 2*smidge + width, smidge + screw_head_height]);
}

module straight_sides(cable_diameter, screw_head_height, width) {
  translate([-cable_diameter/2 - screw_head_height, 0, 0]) 
    cube([cable_diameter + 2 * screw_head_height, width, cable_diameter/2]);
}

module straight_hole(cable_diameter, width) {
  translate([-cable_diameter/2, -smidge, -1]) 
    cube([cable_diameter, 2*smidge + width, cable_diameter/2 + 1]);
}

module base(cable_diameter, screw_head_height, screw_head_diameter, width) {
  translate([-(4 * screw_head_height + cable_diameter + screw_head_diameter)/2, 0, 0]) 
    cube([4 * screw_head_height + cable_diameter + screw_head_diameter, width, screw_head_height]);
}

module u_bracket(cable_diameter, screw_head_height, screw_head_diameter) {
  width = screw_head_diameter + 2 * screw_head_height;
  difference() {
    union() {
      union() {
        outer_ring(cable_diameter, screw_head_height, width);
        straight_sides(cable_diameter, screw_head_height, width);
      }
      base(cable_diameter, screw_head_height, screw_head_diameter, width);
    }
    union() {
      ring_hole(cable_diameter, screw_head_height, width);
      straight_hole(cable_diameter, width);
    }
    open_bottom_of_ring(cable_diameter, screw_head_height, width);
  }
}

u_bracket(cable_diameter = 11, screw_head_height = 4, screw_head_diameter = 9);
