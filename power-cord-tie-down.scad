include <screws.scad>;

smidge = 0.5;
function cable_diameter(dimensions) = dimensions[0];
function screw_head_height(dimensions) = dimensions[1];
function screw_head_diameter(dimensions) = dimensions[2];
function screw_shank_diameter(dimensions) = dimensions[3];

function wall_height(dimensions) = cable_diameter(dimensions)/2;
function thickness(dimensions) = screw_head_height(dimensions);
function screw_padding(dimensions) = thickness(dimensions);
function width(dimensions) = 2 * screw_head_diameter(dimensions);
function tunnel_outside_diameter(dimensions) = cable_diameter(dimensions) + 2 * thickness(dimensions);
function base_extent(dimensions) = tunnel_outside_diameter(dimensions) + 4 * screw_padding(dimensions) + 2 * screw_head_diameter(dimensions);

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

module arch(dimensions, diameter, grow = 0) {
  cylinder_part_of_arch(diameter, grow, width(dimensions));
  straight_sides_of_arch(wall_height(dimensions), diameter, grow, width(dimensions));
}

module tunnel_substance(dimensions) {
  diameter = tunnel_outside_diameter(dimensions);
  arch(dimensions, diameter);
}

module tunnel_hole(dimensions) {
  grow = 2 * smidge;
  diameter = cable_diameter(dimensions);
  arch(dimensions, diameter, grow);
}

module tunnel(dimensions) {
  difference() {
    tunnel_substance(dimensions);
    tunnel_hole(dimensions);
  }
}

module base_plate(dimensions) {
  translate([-base_extent(dimensions)/2, cable_diameter(dimensions)/2 - thickness(dimensions), 0]) 
    cube([base_extent(dimensions), thickness(dimensions), width(dimensions)]);
}

module right_screw_hole(dimensions) {
  translate([0.5*base_extent(dimensions) - screw_padding(dimensions) - screw_head_diameter(dimensions)/2, 0, width(dimensions)/2]) {
    rotate([-90, 0, 0]) {
      screw_hole(screw_shank_diameter(dimensions), screw_head_diameter(dimensions), screw_head_height(dimensions));
    }
  }
}

module base(dimensions) {
  difference() {
    base_plate(dimensions);
    tunnel_hole(dimensions);
    right_screw_hole(dimensions);
  }
}

module tie_down(cable_diameter, screw_head_height, screw_head_diameter, screw_shank_diameter) {
  dimensions = [cable_diameter, screw_head_height, screw_head_diameter, screw_shank_diameter];
  union() {
    tunnel(dimensions);
    base(dimensions);
  }
}

tie_down(cable_diameter = 11, screw_head_height = 4, screw_head_diameter = 9.5, screw_shank_diameter = 4.75);
