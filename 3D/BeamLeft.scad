include <Config.inc>
include <Constants.inc>

use <Beams.scad>

BeamLeft(
    is_printable = true
);

module BeamLeft(
    is_printable = false
) {
    if(is_printable) {
        echo("Print layer-height = 0.06");
        Part();
    } else {
        translate([0,0, shack_raise - bottom_thickness]) {
            translate([wire_pos[1][0] + pole_width / 2,0]) {
                rotate(90, VEC_Y) rotate(-90, VEC_Z) {
                    Part();
                }
            }
        }
        
    }
    module Part() {
        Beam();
    }
}