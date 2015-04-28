
module screw_hole(screw_shank_diameter, screw_head_diameter, screw_head_height, smidge = 0.01) {
  union() {
    cylinder(d = screw_head_diameter, h = 1, $fa = 1, $fs = 1);
    translate([0, 0, 1 - smidge]) {
      cylinder(d = screw_head_diameter, d2 = screw_shank_diameter, h = screw_head_height - 1 + smidge, $fa = 1, $fs = 1);
    }
    translate([0, 0, screw_head_height - smidge]) {
      cylinder(d = screw_shank_diameter, h = 100, $fa = 1, $fs = 1);
    }
  }
}

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

corner(size = 17, wall_thickness = 4, screw_shank_diameter = 4.75, screw_head_diameter = 9.15, screw_head_height = 3.87);
