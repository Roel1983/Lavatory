include <Config.inc>
include <Constants.inc>

Beam();

module Beam(c=0) {
    a= shack_raise / 2;
    b= bridge_length;
    linear_extrude(beam_thickness-tolerance) {
        translate([-shack_depth/2, 0]) {
            square([shack_depth + bridge_length, .6]);
        }
        translate([-wire_pos[0][1] - pole_width / 2, a]) {
            rotate(-45) square([sqrt(2) * a, .6]);
        }
        
        translate([-posses[0][1] + pole_width / 2+c, a]) {
            mirror(VEC_X) rotate(-45) square([sqrt(2) * a, .6]);
        }
        translate([-posses[0][1] - pole_width / 2+c, b]) {
            rotate(-45) square([sqrt(2) * b, .6]);
        }
    }
}
