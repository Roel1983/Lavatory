include <Config.inc>
include <Constants.inc>

use <Walls.scad>

WallLeft(
    is_printable = true
);

module WallLeft(
    is_printable = false
) {
    if(is_printable) {
        echo("Print layer-height = 0.06");
        rotate(90, VEC_X) Part();
    } else {
        translate([+shack_width / 2, 0, 0]) rotate(-90, VEC_Z) {
            Part();
        }
    }
    module Part() { 
        WallSide();
    }
}
