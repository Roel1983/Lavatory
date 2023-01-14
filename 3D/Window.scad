include <Config.inc>

use <AlignedCube.scad>

difference() {
    Window("union");
    Window("difference");
}

module Window(modifier) {
    BIAS = 0.06;
    translate([0, plank_thickness + frame_thickness, 0]) {
        if(modifier == "union") {
            AlignedCube([  window_width + 2 * frame_width, 
                    wall_thickness,
                    window_height + 2 * frame_width
                ], [0, 1,0]);
            
        } else if (modifier == "difference") {
            difference() {
                cube([window_width, 3 * (wall_thickness), window_height],
                    true);
                cube([window_width + 2 * BIAS, 1, 1], true);
                cube([1, 1, window_height + 2 * BIAS], true);
            }
        } else {
            difference() {
                window("union");
                window("difference");                
            }
        }
    }
}