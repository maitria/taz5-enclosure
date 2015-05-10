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

module arch(dimensions, diameter) {
  grow = 0;
  cylinder_part_of_arch(diameter, grow, width(dimensions));
  straight_sides_of_arch(wall_height(dimensions), diameter, grow, width(dimensions));
}

module arch_waste(dimensions) {
  grow = 2 * smidge;
  diameter = cable_diameter(dimensions);
  cylinder_part_of_arch(diameter, grow, width(dimensions));
  straight_sides_of_arch(wall_height(dimensions), diameter, grow, width(dimensions));
}

module tunnel(dimensions) {
  difference() {
    arch(dimensions, cable_diameter(dimensions) + (2 * thickness(dimensions)));
    arch_waste(dimensions);
  }
}

module base(dimensions) {
  base_extent = cable_diameter(dimensions) + 4 * screw_head_diameter(dimensions);
  difference() {
    translate([-base_extent/2, cable_diameter(dimensions)/2 - thickness(dimensions), 0]) 
      cube([base_extent, thickness(dimensions), width(dimensions)]);
    arch_waste(dimensions);
  }
}

function thickness(dimensions) = dimensions[1];
function screw_head_height(dimensions) = thickness(dimensions);
function screw_head_diameter(dimensions) = dimensions[2];
function width(dimensions) = 2 * screw_head_diameter(dimensions);
function cable_diameter(dimensions) = dimensions[0];
function wall_height(dimensions) = cable_diameter(dimensions)/2;

module tie_down(cable_diameter, screw_head_height, screw_head_diameter) {
  dimensions = [cable_diameter, screw_head_height, screw_head_diameter];
  union() {
    tunnel(dimensions);
    base(dimensions);
  }
}

tie_down(cable_diameter = 11, screw_head_height = 2, screw_head_diameter = 5);
