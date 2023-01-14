include <Config.inc>
include <Constants.inc>

use <Walls.scad>

WallBack(
    is_printable = true
);

module WallBack(
    is_printable = false
) {
    if(is_printable) {
        echo("Print layer-height = 0.06");
        rotate(90, VEC_X)Part();
    } else {
        translate([0, +shack_depth / 2, 0]) {
            Part();
        }
    }
    module Part() {
        WallFrontOrBack();
    }
}
