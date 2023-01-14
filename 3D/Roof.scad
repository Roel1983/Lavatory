include <Config.inc>
include <Constants.inc>

use <AlignedCube.scad>

$fn= $preview ? 16 : 128;

Roof(
    is_printable = true
);

module Roof(
    is_printable = false
) {
    if(is_printable) {
        echo("Print layer-height = 0.06");
        rotate(90, VEC_X) Part();
    } else {
        translate([0, 0, shack_height]) {
            Part();
        }
    }
    
    module Part() {
        BIAS = 0.02;
        
        rib_period   = 0.8;
        rib_attitude = 0.4;
        
        max_height = roof_radius + roof_thickness + rib_attitude;
        
        divider = $preview ? 4: 6;
        points = concat(
            [
                for(y=concat(
                    [for(n=[-roof_depth / 2 : rib_period / divider : roof_depth / 2]) n],
                    roof_depth / 2)
                ) [
                    roof_radius + roof_thickness
                        + rib_attitude * (cos(y / rib_period * 360) + 1) / 2,
                    y
                ]
            ], [
                [0, +roof_depth / 2],
                [0, -roof_depth / 2],
            ]
        );
        translate([0, 0, -roof_radius]) intersection() {
            rotate(90, VEC_X)difference() {
                rotate_extrude(convexity=8) polygon(points);
                cylinder(r=roof_radius, h=roof_depth + BIAS*2, center=true);
            }
            AlignedCube([roof_width, roof_depth, max_height], ALIGN_CENTER_BOTTOM);
        }
    }
}