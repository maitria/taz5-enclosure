include <screws.scad>;

module corner(size = 15, wall_thickness = 3, screw_shank_diameter = 4, screw_head_diameter = 9, screw_head_height = 2, smidge = 0.01) {
  difference() {
    cube([size, size, size]);
    translate([wall_thickness, wall_thickness, wall_thickness]) {
      cube([size, size, size]);
    }
    translate([wall_thickness + (size - wall_thickness)/2, wall_thickness + (size - wall_thickness)/2, wall_thickness + smidge]) {
      rotate([180, 0, 0]) screw_hole(screw_shank_diameter, screw_head_diameter, screw_head_height, smidge);
    }
  }
}

corner(size = 17, wall_thickness = 4, screw_shank_diameter = 4.75, screw_head_diameter = 9.35, screw_head_height = 3.87);
