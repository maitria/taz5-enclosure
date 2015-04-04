smidge = 0.5;

module arch(diameter, wall_height, grow, width) {
  translate([0, -.5*grow, wall_height]) rotate([-90, 0, 0]) 
    cylinder(d = diameter, h = grow + width);
}

module outer_ring(cable_diameter, screw_head_height, width) {
  wall_height = cable_diameter/2;
  diameter = cable_diameter + (2 * screw_head_height);
  grow = 0;
  arch(diameter, wall_height, grow, width);
  straight_sides(cable_diameter, screw_head_height, width);
}

module ring_hole(cable_diameter, width) {
  wall_height = cable_diameter/2;
  diameter = cable_diameter;
  grow = 2*smidge;
  arch(diameter, wall_height, grow, width);
  straight_hole(cable_diameter, width);
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
      outer_ring(cable_diameter, screw_head_height, width);
      base(cable_diameter, screw_head_height, screw_head_diameter, width);
    }
    ring_hole(cable_diameter, width);
    open_bottom_of_ring(cable_diameter, screw_head_height, width);
  }
}

u_bracket(cable_diameter = 11, screw_head_height = 4, screw_head_diameter = 9);
