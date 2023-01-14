include <Config.inc>
include <Constants.inc>

use <Roof.scad>
use <Door.scad>
use <WallBack.scad>
use <WallLeft.scad>
use <WallRight.scad>
use <WallFront.scad>
use <Bottom.scad>
use <ColorIf.scad>

Shack();

module Shack() {
    translate([0, 0, shack_raise]) {
        color_if("red", roof_too_big) {
            Roof();
        }
        color_if("red", shack_too_big) {
            WallFront();
            WallLeft();
            WallRight();
            WallBack();
        }
        color_if("red", doorstep_too_big) {
            Bottom();
        }
        Door(position = 60);
    }
}
