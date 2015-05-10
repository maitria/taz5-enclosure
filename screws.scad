
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

