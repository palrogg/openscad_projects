/*
* Parameters
*/
BOARD_WIDTH = 20.1;
BOARD_LENGTH = 40.3;
WALL_THICKNESS = 1.4;
PLATE_HEIGHT = 6;

// Measure the distance between the back of the board
// and the center of the cylinder
CYLINDER_YPOSITION_FROM_BACK = 10;
CYLINDER_HEIGHT = PLATE_HEIGHT - 2;
CYLINDER_RADIUS = 2.2;

cylinder_yposition = BOARD_LENGTH/2 + WALL_THICKNESS - CYLINDER_YPOSITION_FROM_BACK;
XS = 0.001;

plate_width = BOARD_WIDTH + 2 * WALL_THICKNESS;
plate_length = BOARD_LENGTH + 2 * WALL_THICKNESS;

include <BOSL2/std.scad>

module plate() {
    difference() {
        translate([0, 0, (WALL_THICKNESS+4) / 2]) {
            cuboid([
                plate_width,
                plate_length,
                PLATE_HEIGHT
            ], rounding=0.4, trimcorners=false, anchor=[0, 0, 0]);
        }
        translate([0, 0, (PLATE_HEIGHT - WALL_THICKNESS + XS) / 2 + WALL_THICKNESS]) {
          cube([
            BOARD_WIDTH, BOARD_LENGTH, PLATE_HEIGHT - WALL_THICKNESS + XS
            ], center=true);
        };
    }
}

module 2mm_cylinder(x, y, z){
    translate([x, y, z]){
        cylinder(h=CYLINDER_HEIGHT + XS, r=CYLINDER_RADIUS, $fn=15);
    }
}

module plate_and_cylinders() {
    difference(){
        union(){
            plate();

            // Left cylinder
            2mm_cylinder(-BOARD_WIDTH/2, cylinder_yposition, 0);

            // Right cylinder
            2mm_cylinder(BOARD_WIDTH/2, cylinder_yposition, 0);
            
            // Middle cylinder
            2mm_cylinder(0, -BOARD_LENGTH/2, 0);

        }
        // Substract above left cylinder
        2mm_cylinder(-BOARD_WIDTH/2, cylinder_yposition, CYLINDER_HEIGHT);
        // Substract above right cylinder
        2mm_cylinder(BOARD_WIDTH/2, cylinder_yposition, CYLINDER_HEIGHT);
        // Substract above middle cylinder
        2mm_cylinder(0, -BOARD_LENGTH/2, CYLINDER_HEIGHT);
        
        // Plate is larger at the center
        translate([-BOARD_WIDTH/2 - 10, -5, CYLINDER_HEIGHT]) cube([40, 10, 5], center = false);
    }
}

// If you don't include the file and
// want to generate this object only, run:
// plate_and_cylinders();