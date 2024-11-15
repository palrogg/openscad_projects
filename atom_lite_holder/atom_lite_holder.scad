include <BOSL2/std.scad>

ATOM_WIDTH = 24.1;
WALL_THICKNESS = 2;
BOTTOM_THICKNESS = 1.4;
holder_width = ATOM_WIDTH + 2*WALL_THICKNESS;
EMPTY_SQUARE_WIDTH = 16;
HEIGHT = 14.4;

difference(){
    cuboid([holder_width, holder_width, HEIGHT], rounding=0.4, trimcorners=false, anchor=[-1, -1, -1]);
    translate([WALL_THICKNESS, WALL_THICKNESS, BOTTOM_THICKNESS]) cube([ATOM_WIDTH, ATOM_WIDTH, HEIGHT]);
    translate([6, -10, BOTTOM_THICKNESS]) cube([EMPTY_SQUARE_WIDTH, 50, HEIGHT]);
    translate([-10, 6, BOTTOM_THICKNESS]) cube([30, EMPTY_SQUARE_WIDTH, HEIGHT]);
    for(z=[BOTTOM_THICKNESS:2.6:HEIGHT - BOTTOM_THICKNESS]){
        translate([ATOM_WIDTH, 4, z]) cube([8, 20, 1.2]);
    }
}
