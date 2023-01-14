include <Config.inc>

use <Shack.scad>
use <Shack.scad>
use <BeamLeft.scad>
use <BeamRight.scad>
use <Socket.scad>
use <ServoMount.scad>

Lavatory();

module Lavatory() {
    Shack();
    BeamLeft();
    BeamRight();
    Socket();
    ServoMount();
}
