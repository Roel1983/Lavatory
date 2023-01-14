include <Config.inc>
include <Constants.inc>

use <AlignedCube.scad>

$fn = 64;

Socket();

module Socket() {
    BIAS = 0.01;
    difference() {
        union() {
            translate([0,0, -socket_height - BIAS]) {
                cylinder(d=socket_diameter, h=socket_height + BIAS);
            }
            if(shack_raise == 0) {
                color_if("red", doorstep_too_big) bottom();
            }
            translate([0,0, -socket_height])
            AlignedCube([35,35,base_thickness], [0,0,1]);
            for (pos = posses) {
                translate([pos[0], pos[1], -BIAS]) {
                    linear_extrude(shack_raise - bottom_thickness + BIAS)                    square(pole_width, true);
                }
            }
        }
        translate([-hinge_x, -hinge_y-shack_depth / 2]) {
            
        }
        
        translate([-hinge_x, -hinge_y-shack_depth / 2, 
            -socket_height - base_thickness])
        {
            translate([0,-8.6]) cylinder(d=3.2, h=6+2*BIAS, center = true);
            translate([0,27.7-8.6]) cylinder(d=3.2, h=6+2*BIAS, center = true);
        }
        for(x=[-12,12], y=[-12,12]) translate([x,y, -14]) {
            cylinder(d1=10, d2=4,3);
            cylinder(d=4,100);
        }
        for (pos = posses) {
            translate([pos[0], pos[1]]) {
                linear_extrude(2*shack_height, center=true) {
                    square(1.3, true);
                }
            }   
        }
        for (pos = wire_pos) {
            h=base_thickness+socket_height - 1.5 -1;
            translate([pos[0], pos[1], -base_thickness-socket_height]) {
                cylinder(d=3, h=2*h, center= true);
                translate([0,0,h]) cylinder(d1=3, d2=0, h=1.5);
                translate([-1.7/2, 1/7/2, 1.7]) {
                    rotate(-90, VEC_X) cube([1.7, 2.6, 35]);
                }
            }
        }
    }
}