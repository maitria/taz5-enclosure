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

module arch_waste(dimensions) {
    arch(wall_height(dimensions), cable_diameter(dimensions), 2 * smidge, width(dimensions));
}

module base(cable_diameter, thickness, screw_head_diameter, width, dimensions) {
  base_extent = cable_diameter + 4 * screw_head_diameter;
  difference() {
    translate([-(base_extent)/2, cable_diameter/2 - thickness, 0]) 
      cube([base_extent, thickness, width]);
    arch_waste(dimensions);
  }
}

function thickness(dimensions) = dimensions[1];
function screw_head_diameter(dimensions) = dimensions[2];
function width(dimensions) = 2 * screw_head_diameter(dimensions);
function cable_diameter(dimensions) = dimensions[0];
function wall_height(dimensions) = cable_diameter(dimensions)/2;

module tie_down(cable_diameter, screw_head_height, screw_head_diameter) {
  dimensions = [cable_diameter, screw_head_height, screw_head_diameter];
  left_base(screw_head_diameter(dimensions), thickness(dimensions), width(dimensions));
  union() {
    hollow_arch(cable_diameter(dimensions), thickness(dimensions), width(dimensions));
    base(cable_diameter, screw_head_height, screw_head_diameter, width(dimensions), dimensions);
  }
}

tie_down(cable_diameter = 11, screw_head_height = 2, screw_head_diameter = 5);
