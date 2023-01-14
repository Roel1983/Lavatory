include <Config.inc>

use <AlignedCube.scad>
use <ColorIf.scad>

$fn=32;

Bottom();

module Bottom() {
    difference() {
        union() {
            translate([0,0,.5*floor_thickness]) {
                cube([shack_width - 2 * wall_thickness - 2 * tolerance,
                      shack_depth - 2 * wall_thickness - 2 * tolerance,
                      floor_thickness], true);
            }
            translate([0,
                       -wall_thickness - frame_thickness - 
                           plank_thickness - doorstep,
                       .5*floor_thickness])
            {
               cube([door_width - .2,
                  shack_depth - 2 * wall_thickness,
                  floor_thickness], true);
            }
            translate([0, (shack_depth - 2 * wall_thickness)/2 - .2]) {
                AlignedCube([shack_width - 2 * wall_thickness - .2, 4.5, 6], 
                             [0,1,-1]);
            }
            translate([0,0,-bottom_thickness/2]) {
                cube([shack_width + 2 * (plank_thickness + frame_thickness),
                      shack_depth + 2 * (plank_thickness + frame_thickness),
                      bottom_thickness], true);
            }
            color_if("red", bridge_length_too_big) {
                AlignedCube([bridge_width, bridge_length + shack_depth / 2, bottom_thickness], [0,1,1]);
            }
        }
        for (pos = posses) {
            translate([pos[0], pos[1]]) {
                linear_extrude(2*shack_height, center=true) {
                    circle(d=1.3, true);
                }
            }   
        }
    }
}