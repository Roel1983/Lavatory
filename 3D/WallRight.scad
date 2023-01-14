include <Config.inc>
include <Constants.inc>

use <Walls.scad>
use <Window.scad>

WallRight(
    is_printable = true
);

module WallRight(
    is_printable = false
) {
    if(is_printable) {
        echo("Print layer-height = 0.06");
        rotate(90, VEC_X) Part();
    } else {
        translate([-shack_width / 2, 0, 0]) rotate(90, VEC_Z) {
            Part();
        }
    }
    module Part() { 
        difference() {
            union() {
                WallSide();
                translate([0,0,window_ver_pos]) Window("union");
            }
            translate([0,0,window_ver_pos]) Window("difference");
        }
    }
}
