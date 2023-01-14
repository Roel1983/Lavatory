include <Config.inc>
include <Constants.inc>

$fn = 32;

ServoMount(
    is_printable = true
);

module ServoMount(
    is_printable = false
) {
    if(is_printable) {
        echo("Print layer-height = 0.15");
        rotate(90, VEC_Y) Part();
    } else {
        Part();
    }
    
    module Part() {
        BIAS = 0.01;
        translate([-hinge_x, -hinge_y-shack_depth / 2, 
                    -socket_height - base_thickness - 14])
        {
            difference() {
                union() {
                    translate([(-12.2+3)/2, -5.8-4.8]) cube([12.2+3,32.2, 14]);
                    translate([+12.2/2, -5.8-4.8,-14]) cube([4.5,12, 18]);
                }
                translate([-12.2/2, -5.6-.8,-BIAS]) cube([12.2,23, 17+2+2*BIAS]);
                
                translate([-12.2/2, -5.6,-BIAS]) cube([12.2,22.6, 17+2+2*BIAS]);
                
                translate([0,-8.6,-BIAS]) cylinder(d=2.4, h=17 + 2 * BIAS);
                translate([0,27.7-8.6,-BIAS]) cylinder(d=2.4, h=17 + 2 * BIAS);
                for(z=[1,1+13.8]) translate([12.2/2+4.5,-3,5 -z]) rotate(90, VEC_Y) {
                    cylinder(d=4, h=9+2*BIAS, center=true);
                }translate([0,0,14]) {
                    intersection() {
                        cylinder(r=17,h=2*6,center=true);
                        translate([0,40/2-5.5,0])cube(40,true);
                    }
                }
            }
        }
    }
}