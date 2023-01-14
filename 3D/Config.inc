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


plank_width = 0.75;
plank_thickness = 0.24;

socket_diameter = 24.8;
socket_height = 9.5;

base_thickness = 3;
tolerance = 0.1;

/* Derived */
frame_thickness = 0.06 * 4;
pole_width = 0.5 * 2 + 1.3;

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