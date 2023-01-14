include <Config.inc>

use <AlignedCube.scad>

difference() {
    DoorFrame("union");
    DoorFrame("difference");
}

module DoorFrame(modifier) {
    BIAS = 0.05;
    
    if(modifier == "union") {
        translate([0, plank_thickness + frame_thickness,0]) {
            AlignedCube([  door_width + 2 * frame_width, 
                    wall_thickness,
                    door_height + frame_width
                ], [0, 1,-1]);
        }
    } else if (modifier == "difference") {
        cube([  door_width, 
                2 * (wall_thickness + BIAS),
                2 * door_height
            ], true);
    } else {
        difference() {
            door_frame("union");
            door_frame("difference");                
        }
    }
}