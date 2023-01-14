include <Constants.inc>
include <Config.inc>

Door(
    is_printable = true
);

module Door(
    position     = 0,
    is_printable = false
) {
    door_thickness = 0.06 * 7;
    
    if (is_printable) {
        echo("Print layer-height = 0.06");
        rotate(45, VEC_Z) Part();
    } else {
        translate([
            -door_width / 2 + .25,
            -shack_depth/2,
            floor_thickness / 2 + door_height /2])
        {
            rotate(-position, VEC_Z) {
                rotate(90, VEC_X) Part();
            }
        }
    }
    module Part() {
        h = door_height - 0.5 - floor_thickness;
        translate([door_width /2, 0]) {
            cube([door_width - 0.5, h, door_thickness], true);
            intersection() {
                union() {
                    for (y=[-(h - frame_width)/2, 0, (h - frame_width)/2]) {
                        translate([0, y]) {
                            cube([door_width - 0.5,
                                    frame_width,
                                    2 * 0.06 * 2 + door_thickness
                                 ], true);
                        }
                    }
                    for (y=[-(h - frame_width)/4, (h - frame_width)/4]) translate([0, y]) {
                        rotate(50) {
                            cube([door_width * 1.5,
                                     frame_width,
                                     2 * 0.06 * 2 + door_thickness
                                 ], true);
                        }
                    }
                }
                translate([0,0, (frame_thickness + door_thickness) / 2]) {
                    cube([door_width - 0.5, h,  frame_thickness + door_thickness], true);
                }
            }
        }
    }
}