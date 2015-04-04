smidge = 0.5;

module cylinder_part_of_arch(wall_height, diameter, grow, width) {
  translate([0, 0, -.5*grow])
    intersection() {
      cylinder(d = diameter, h = grow + width);
      translate([-.5*diameter, -.5*diameter, 0]) cube([diameter, diameter/2+smidge, width+2*smidge]);
    }
}

module straight_sides_of_arch(wall_height, diameter, grow, width) {
  translate([-diameter/2, 0, -.5*grow]) 
    cube([diameter, wall_height + grow, width + grow]);
}

module arch(wall_height, diameter, grow, width) {
  cylinder_part_of_arch(wall_height, diameter, grow, width);
  straight_sides_of_arch(wall_height, diameter, grow, width);
}

module hollow_arch(cable_diameter, screw_head_height, width) {
  difference() {
    outer_arch(cable_diameter, screw_head_height, width);
    waste_in_ring(cable_diameter, width);
  }
}

module outer_arch(cable_diameter, screw_head_height, width) {
  wall_height = cable_diameter/2;
  diameter = cable_diameter + (2 * screw_head_height);
  grow = 0;
  arch(wall_height, diameter, grow, width);
}

module waste_in_ring(cable_diameter, width) {
  wall_height = cable_diameter/2;
  diameter = cable_diameter;
  grow = 2*smidge;
  arch(wall_height, diameter, grow, width);
}

module base(cable_diameter, screw_head_height, screw_head_diameter, width) {
  difference() {
    translate([-(4 * screw_head_height + cable_diameter + screw_head_diameter)/2, cable_diameter/2 - screw_head_height, 0]) 
      cube([4 * screw_head_height + cable_diameter + screw_head_diameter, screw_head_height, width]);
    waste_in_ring(cable_diameter, width);
  }
}

module u_bracket(cable_diameter, screw_head_height, screw_head_diameter) {
  width = screw_head_diameter + 2 * screw_head_height;
  union() {
    hollow_arch(cable_diameter, screw_head_height, width);
    base(cable_diameter, screw_head_height, screw_head_diameter, width);
  }
}

u_bracket(cable_diameter = 11, screw_head_height = 2, screw_head_diameter = 5);
