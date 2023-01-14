include <Config.inc>
include <Constants.inc>

use <Walls.scad>
use <DoorFrame.scad>

WallFront(
    is_printable = true
);

module WallFront(
    is_printable = false
) {
    if(is_printable) {
        echo("Print layer-height = 0.06");
        rotate(90, VEC_X) Part();
    } else {
        translate([0, -shack_depth / 2, 0]) rotate(180, VEC_Z) {
            Part();
        }
    }
    module Part() { 
        difference() {
            union() {
                WallFrontOrBack();
                DoorFrame("union");
            }
            DoorFrame("difference");
            translate([hinge_x, hinge_y, 0]) {
                cylinder(d=.75, h= door_height + 0.5);
            }
        }
    }
}