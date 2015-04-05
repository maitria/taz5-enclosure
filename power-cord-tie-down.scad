smidge = 0.5;

module cylinder_part_of_arch(diameter, grow, width) {
  translate([0, 0, -.5*grow])
    intersection() {
      cylinder(d = diameter, h = grow + width);
      translate([-.5*diameter, -.5*diameter, 0]) 
        cube([diameter, diameter/2+smidge, width+2*smidge]);
    }
}

module straight_sides_of_arch(wall_height, diameter, grow, width) {
  translate([-diameter/2, 0, -.5*grow]) 
    cube([diameter, wall_height + grow, width + grow]);
}

module arch(wall_height, diameter, grow, width) {
  cylinder_part_of_arch(diameter, grow, width);
  straight_sides_of_arch(wall_height, diameter, grow, width);
}

module hollow_arch(cable_diameter, thickness, width) {
  difference() {
    arch(cable_diameter/2, cable_diameter + (2 * thickness), 0, width);
    arch(cable_diameter/2, cable_diameter, 2 * smidge, width);
  }
}

module arch_waste(cable_diameter, width) {
    arch(cable_diameter/2, cable_diameter, 2 * smidge, width);
}

module base(cable_diameter, thickness, screw_head_diameter, width) {
  base_extent = cable_diameter + 4 * screw_head_diameter;
  difference() {
    translate([-(base_extent)/2, cable_diameter/2 - thickness, 0]) 
      cube([base_extent, thickness, width]);
    arch_waste(cable_diameter, width);
  }
}

module u_bracket(cable_diameter, screw_head_height, screw_head_diameter) {
  thickness = screw_head_height;
  width = 2 * screw_head_diameter;
  left_base(screw_head_diameter, thickness, width);
  union() {
    hollow_arch(cable_diameter, thickness, width);
    base(cable_diameter, screw_head_height, screw_head_diameter, width);
  }
}

u_bracket(cable_diameter = 11, screw_head_height = 2, screw_head_diameter = 5);
