
module corner(size = 15, wall_thickness = 3, screw_shank_diameter = 4, screw_head_diameter = 9, screw_head_height = 2, smidge = 0.01) {
  difference() {
    cube([size, size, size]);
    translate([wall_thickness, wall_thickness, wall_thickness]) {
      cube([size, size, size]);
    }
    translate([wall_thickness + (size - wall_thickness)/2, wall_thickness + (size - wall_thickness)/2, 0]) {
      union() {
        translate([0, 0, wall_thickness - screw_head_height]) {
          cylinder(d = screw_shank_diameter, d2 = screw_head_diameter, h = screw_head_height + smidge, $fa = 1, $fs = 1);
        }
        translate([0, 0, -smidge]) {
          cylinder(d = screw_shank_diameter, h = wall_thickness + 2 * smidge, $fa = 1, $fs = 1);
        }
      }
    }
  }
}

corner(size = 15, wall_thickness = 3, screw_shank_diameter = 4, screw_head_diameter = 9, screw_head_height = 2);
