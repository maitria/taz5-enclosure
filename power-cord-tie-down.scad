module outer_ring(cable_diameter, screw_head_height, width) {
  wall_height = cable_diameter/2;
  outside_diameter = cable_diameter + (2 * screw_head_height);
  translate([0, 0, wall_height]) rotate([-90, 0, 0]) 
    cylinder(d = outside_diameter, h = width);
}

module ring_hole(cable_diameter, screw_head_height, width) {
  wall_height = cable_diameter/2;
  translate([0, -0.5, wall_height]) rotate([-90, 0, 0]) 
    cylinder(d = cable_diameter, h = 1 + width);
}

module entire_ring(cable_diameter, screw_head_height, width) {
  difference() {
    outer_ring(cable_diameter, screw_head_height, width);
    inner_ring(cable_diameter, screw_head_height, width);
  }
}

module open_bottom_of_ring(cable_diameter, screw_head_height, width) {
  translate([-cable_diameter/2 - screw_head_height, -0.5, -(1 + screw_head_height)]) 
    cube([cable_diameter + 2 * screw_head_height, 1 + width, 1 + screw_head_height]);
}

module straight_sides(cable_diameter, screw_head_height, width) {
  translate([-cable_diameter/2 - screw_head_height, 0, 0]) 
    cube([cable_diameter + 2 * screw_head_height, width, cable_diameter/2]);
}

module straight_hole(cable_diameter, width) {
  translate([-cable_diameter/2, -0.5, -1]) 
    cube([cable_diameter, 1 + width, cable_diameter/2 + 1]);
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
