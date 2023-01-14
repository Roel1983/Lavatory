include <Config.inc>
include <Constants.inc>

translate([-10, 0]) WallFrontOrBack();
translate([ 10, 0]) WallSide();

module WallFrontOrBack() {
    intersection() {
        Wall([shack_width, shack_height]);
        WallIntersecter();
    }
}

module WallSide() {
    intersection() {
        Wall([shack_depth, shack_height]);
        translate([0,-shack_width/2])rotate(90, VEC_Z) WallIntersecter();
    }
}

module Wall(dim) {
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
    linear_extrude(dim[1], convexity =2) polygon(points, convexity=1);
}

module WallIntersecter() {
    translate([0,0, shack_height - roof_radius]) {
        rotate(90, VEC_X) {
            cylinder(r = roof_radius, h = 2 * shack_depth, center=true);
        }
    }
}