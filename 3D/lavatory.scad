
part( "door" );

preview = true;

shack_width = 15;
shack_depth = 14;
shack_height = 25;

shack_raise = 11;

roof_overhang = 1.5;
roof_radius = 15;
roof_thickness = 0.5;

bottom_thickness = .8;

door_width = 8;
door_height = 20;
doorstep = 1;

bridge_length = 7;

window_width = 6;
window_height = 6;
window_ver_pos = 16;

wall_thickness = 1;
floor_thickness = 1;

frame_width = 0.75;
frame_thickness = 0.06 * 4;

plank_width = 0.75;
plank_thickness = 0.24;

socket_diameter = 24.8;
socket_height = 9.5;

pole_width = 0.5 * 2 + 1.3;

base_thickness = 3;
tolerance = 0.1;

BIAS = 0.02;
INV = 100;

X_AXIS = [1, 0, 0];
Y_AXIS = [0, 1, 0];
Z_AXIS = [0, 0, 1];

ALIGN_CENTER_BOTTOM = [0, 0, -1];

roof_width = shack_width + 2 * roof_overhang;
roof_depth = shack_depth + 2 * roof_overhang;

hinge_x = door_width / 2 - 1.5;
hinge_y = (frame_thickness + plank_thickness - wall_thickness) / 2;


wire_pos = [[shack_width / 2 - wall_thickness - 1.3 / 2,
             shack_depth / 2 - wall_thickness - 1.3 / 2],
            [-shack_width / 2 + wall_thickness + 1.3 / 2,
             shack_depth / 2 - wall_thickness - 1.3 / 2]];
bridge_width = 2 * wire_pos[0][0] - pole_width + 1;

posses = concat([
        [-hinge_x, -hinge_y-shack_depth / 2],
        [wire_pos[0][0], -wire_pos[0][1]]
    ], wire_pos);

beam_thickness = wire_pos[0][0] + posses[0][0] - pole_width;

roof_too_big  = (sqrt(pow(roof_width, 2) + pow(roof_depth, 2)) > socket_diameter);
if (roof_too_big) {
   echo("WARNING: The roof is bigger than the hole for the socket!!!");
}

shack_too_big = (sqrt(pow(shack_width + 2 * (plank_thickness + frame_thickness), 2) + pow(shack_depth + 2 * (plank_thickness + frame_thickness), 2)) > socket_diameter);
if (roof_too_big) {
   echo("WARNING: The shack is bigger than the hole for the socket!!!");
}   

doorstep_too_big = (shack_raise - bottom_thickness > socket_height)
    ? (sqrt(pow(shack_depth + doorstep, 2) + pow((shack_width + door_width)/2, 2)) > socket_diameter)
    : (sqrt(pow(shack_depth / 2 + doorstep, 2) + pow(door_width/2, 2)) > socket_diameter/2);
if(doorstep_too_big) {
    echo("WARNING: The doorstep is bigger than the hole for the socket!!!");
}

bridge_length_too_big = (shack_raise - bottom_thickness > socket_height)
    ? (sqrt(pow(shack_depth + bridge_length, 2) + pow((shack_width + bridge_width)/2, 2)) > socket_diameter)
    : (sqrt(pow(shack_depth / 2 + bridge_length, 2) + pow(bridge_width/2, 2)) > socket_diameter/2);
if(bridge_length_too_big) {
    echo("WARNING: The bridge length is bigger than the hole for the socket!!!");
}

module part(part = "all") {
    $fn= preview ? 16 : 64;
    if (part == "roof") {
        $fn= 128;
        rotate(90, X_AXIS) roof();
        echo("Print layer-height = 0.06");
    } else if (part == "wall_back") {
        $fn= 64;
        rotate(-135, Z_AXIS) rotate(90, X_AXIS) wall_back();
        echo("Print layer-height = 0.06");
    } else if (part == "wall_left") {
        $fn= 64;
        rotate(-135, Z_AXIS) rotate(90, X_AXIS) wall_left();
        echo("Print layer-height = 0.06");
    } else if (part == "wall_right") {
        $fn= 64;
        rotate(-135, Z_AXIS) rotate(90, X_AXIS) wall_right();
        echo("Print layer-height = 0.06");
    } else if (part == "wall_front") {
        $fn= 64;
        rotate(-135, Z_AXIS) rotate(90, X_AXIS) wall_front();
        echo("Print layer-height = 0.06");
    } else if (part == "bottom") {
        bottom();
    } else if (part == "door") {
        rotate(45, Z_AXIS) door();
    } else if (part == "socket") {
        $fn= 128;
        echo("Print layer-height = 0.15");
        socket();
    } else if (part == "beam_left") {
        echo("Print layer-height = 0.06");
        beam_left();
    } else if (part == "beam_right") {
        echo("Print layer-height = 0.06");
        beam_right();
    } else if (part == "servo_mount") {    
        $fn= 64;
        echo("Print layer-height = 0.15");
        rotate(90, Y_AXIS) servo_mount();
    } else if (part == "shack") {
        translate([0, 0, shack_height]) {
            color_if("red", roof_too_big) roof();
        }
        color_if("red", shack_too_big) {
            translate([0, -shack_depth / 2, 0]) rotate(180, Z_AXIS) {
               wall_front();
            }
            translate([+shack_width / 2, 0, 0]) rotate(-90, Z_AXIS) {
               wall_left();
            }
            translate([-shack_width / 2, 0, 0]) rotate(90, Z_AXIS) {
               wall_right();
            }
            translate([0, +shack_depth / 2, 0]) wall_back();
        }
        color_if("red", doorstep_too_big) {
            bottom();
        }
        translate([
            -door_width / 2 + .25,
            -shack_depth/2,
            floor_thickness / 2 + door_height /2])
        {
            rotate(-60, Z_AXIS) rotate(90, X_AXIS) door();
        }
    } else if (part == "all") {
        translate([0, 0, shack_raise]) {
            part("shack");
        }
        translate([0,0, shack_raise - bottom_thickness]) {
            translate([wire_pos[1][0] + pole_width / 2,0]) {
                rotate(90, Y_AXIS) rotate(-90, Z_AXIS) beam_left();
            }
            translate([wire_pos[0][0] - pole_width / 2,0]) {
                rotate(-90, Y_AXIS) rotate(90, Z_AXIS) beam_right();
            }
        }
        socket();
        servo_mount();
    }
}

module door() {
    door_thickness = 0.06*7;
    
    h = door_height - 0.5 - floor_thickness;
    translate([door_width /2, 0]) {
        cube([door_width - 0.5, h, door_thickness], true);
        intersection() {
            union() {
                for (y=[-(h - frame_width)/2, 0, (h - frame_width)/2]) {
                    translate([0, y]) {
                        cube([door_width - 0.5,
                                frame_width,
                                2 * 0.06 * 2 + door_thickness
                             ], true);
                    }
                }
                for (y=[-(h - frame_width)/4, (h - frame_width)/4]) translate([0, y]) {
                    rotate(50) {
                        cube([door_width * 1.5,
                                 frame_width,
                                 2 * 0.06 * 2 + door_thickness
                             ], true);
                    }
                }
            }
            translate([0,0, (frame_thickness + door_thickness) / 2]) {
                cube([door_width - 0.5, h,  frame_thickness + door_thickness], true);
            }
        }
    }
}
module beam_left() {
    beam();
}
module beam_right() {
    mirror(X_AXIS) {
        beam(-1.5);
    }
}
module beam(c=0) {
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
            mirror(X_AXIS) rotate(-45) square([sqrt(2) * a, .6]);
        }
        translate([-posses[0][1] - pole_width / 2+c, b]) {
            rotate(-45) square([sqrt(2) * b, .6]);
        }
    }
}

module socket() {
    difference() {
        union() {
            translate([0,0, -socket_height - BIAS]) {
                cylinder(d=socket_diameter, h=socket_height + BIAS);
            }
            if(shack_raise == 0) {
                color_if("red", doorstep_too_big) bottom();
            }
            translate([0,0, -socket_height])
            aligned_cube([35,35,base_thickness], [0,0,1]);
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
                    rotate(-90, X_AXIS) cube([1.7, 2.6, 35]);
                }
            }
        }
    }
    
    
}

module servo_mount() {
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
            for(z=[1,1+13.8]) translate([12.2/2+4.5,-3,5 -z]) rotate(90, Y_AXIS) {
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

module bottom() {
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
                aligned_cube([shack_width - 2 * wall_thickness - .2, 4.5, 6], 
                             [0,1,-1]);
            }
            translate([0,0,-bottom_thickness/2]) {
                cube([shack_width + 2 * (plank_thickness + frame_thickness),
                      shack_depth + 2 * (plank_thickness + frame_thickness),
                      bottom_thickness], true);
            }
            color_if("red", bridge_length_too_big) {
                aligned_cube([bridge_width, bridge_length + shack_depth / 2, bottom_thickness], [0,1,1]);
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


module wall_front() {
    render(convexity = 1) difference() {
        union() {
            wall_front_back();
            door_frame("union");
        }
        door_frame("difference");
        translate([hinge_x, hinge_y, 0]) {
            cylinder(d=.75, h= door_height + 0.5);
        }
    }
}

module wall_left() {
    render(convexity = 1) wall_side();
}

module wall_right() {
    render(convexity = 1) difference() {
        union() {
            wall_side();
            translate([0,0,window_ver_pos]) window("union");
        }
        translate([0,0,window_ver_pos]) window("difference");
    }
}

module wall_back() {
    render(convexity = 1) wall_front_back();
}

module door_frame(modifier) {
    if(modifier == "union") {
        translate([0, plank_thickness + frame_thickness,0]) {
            aligned_cube([  door_width + 2 * frame_width, 
                    wall_thickness,
                    door_height + frame_width
                ], [0, 1,-1]);
        }
    } else if (modifier == "difference") {
        cube([  door_width, 
                2 * (wall_thickness + BIAS),
                2 * door_height
            ], true);
    } else {
        difference() {
            door_frame("union");
            door_frame("difference");                
        }
    }
}

module window(modifier) {
    translate([0, plank_thickness + frame_thickness, 0]) {
        if(modifier == "union") {
            
                aligned_cube([  window_width + 2 * frame_width, 
                        wall_thickness,
                        window_height + 2 * frame_width
                    ], [0, 1,0]);
            
        } else if (modifier == "difference") {
            difference() {
                cube([window_width, 3 * (wall_thickness), window_height],
                    true);
                cube([window_width + 2 * BIAS, 1, 1], true);
                cube([1, 1, window_height + 2 * BIAS], true);
            }
        } else {
            difference() {
                window("union");
                window("difference");                
            }
        }
    }
}

module wall_side() {
    intersection() {
        wall([shack_depth, shack_height]);
        translate([0,-shack_width/2])rotate(90, Z_AXIS) wall_intersecter();
    }
}

module wall_front_back() {
    intersection() {
        wall([shack_width, shack_height]);
        wall_intersecter();
    }
}

module wall_intersecter() {
    translate([0,0, shack_height - roof_radius]) {
        rotate(90, X_AXIS) {
            cylinder(r = roof_radius, h = 2 * shack_depth, center=true);
        }
    }
}

module wall(dim) {
    plank_number = floor((dim[0] / plank_width - 2) / 2) * 2;
    points = concat(
        [
            for(i=[-plank_number/2:2:plank_number/2], j=[0:3]) [
                (i + (j <= 1?-.5:.5)) * plank_width,
                j == 0 || j == 3 ? 0 : plank_thickness
            ]
        ], [
            [ dim[0]/2,0],
            [ dim[0]/2-wall_thickness,-wall_thickness],
            [-dim[0]/2+wall_thickness,-wall_thickness],
            [-dim[0]/2,0]
        ]
    );
    linear_extrude(dim[1]) polygon(points, convexity=1);
}

module roof() {
    rib_period   = 0.8;
    rib_attitude = 0.4;
    
    max_height = roof_radius + roof_thickness + rib_attitude;
    
    divider = preview ? 4: 6;
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
        rotate(90, X_AXIS)difference() {
            rotate_extrude(convexity=8) polygon(points);
            cylinder(r=roof_radius, h=roof_depth + BIAS*2, center=true);
        }
        aligned_cube([roof_width, roof_depth, max_height], ALIGN_CENTER_BOTTOM);
    }
}

module copy_mirror(vec) {
    children();
    mirror(vec) children();
} 

module color_if(c, predicate) {
    if (predicate) {
        color(c) children();
    } else {
        children();
    }
}

module aligned_cube(dim, alignment) {
    translate(array_mul(dim, [-.5,-.5,-.5], alignment)) cube(dim, true);
}

function array_mul(a, b, c, d, e) = (c != undef)
    ? array_mul(array_mul(a, b), c, d, e)
    : [for(n=[0:min(len(a),len(b))-1])a[n]*b[n]];

function list(a, n) = [
    for(i=[0:n-1])a 
];