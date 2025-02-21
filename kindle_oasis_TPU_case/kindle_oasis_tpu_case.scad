/**
*
* TPU Case for Kindle Oasis (10th Gen)
* Kindle Oasis Size: 15.9×14.1×0.84	cm
* License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.html#license-text
*
*/

include <BOSL2/std.scad>

USE_PLA = false;
TEST_MODEL = false;
XY_CLEARING = 0.8;
Z_CLEARING = 1.2;
KINDLE_WIDTH = 142 + XY_CLEARING;
KINDLE_HEIGHT = 159 + XY_CLEARING;

KINDLE_MAX_THICKNESS = 8.4 + Z_CLEARING;
KINDLE_MIN_THICKNESS = 3.4 + Z_CLEARING;
WALL_THICKNESS = 1.2; //vs 0.8 for PLA

// We raise the case where the Kindle thickness is only 3.4mm
RAISED_WIDTH = 80; // 4mm gap 
// RAISED_WIDTH = 20; // PLA version
RAISED_HEIGHT = 0.45 * KINDLE_HEIGHT;
RAISED_THICKNESS = KINDLE_MAX_THICKNESS - KINDLE_MIN_THICKNESS;
NEAR_ZERO = 0.001;

module case(){
    union(){

        difference(){
            // Outer case frame
            cuboid([
                KINDLE_WIDTH + 2*WALL_THICKNESS,
                KINDLE_HEIGHT + 2*WALL_THICKNESS,
                KINDLE_MAX_THICKNESS + WALL_THICKNESS,
            ], rounding=1.2, trimcorners=true);
            
            // Inner case frame
            translate([0, 0, WALL_THICKNESS*0])
            cuboid([
                KINDLE_WIDTH,
                KINDLE_HEIGHT,
                KINDLE_MAX_THICKNESS-WALL_THICKNESS,
            ], rounding=1.2, trimcorners=true);
            
            // Top inner case frame
            intersection(){
                translate([0, 0, KINDLE_MAX_THICKNESS-NEAR_ZERO]){
                cuboid([
                    KINDLE_WIDTH-2.8,
                    KINDLE_HEIGHT-2.8,
                    20,
                ], rounding=1.2, trimcorners=true);
                if(USE_PLA){
                    translate([0, 0, -WALL_THICKNESS])
                    union(){
                        cube([1.2*KINDLE_WIDTH, 0.7*KINDLE_HEIGHT, KINDLE_MAX_THICKNESS], center=true);
                        cube([0.7*KINDLE_WIDTH, 1.2*KINDLE_HEIGHT, KINDLE_MAX_THICKNESS], center=true);
                        }
                    }
                }
            }
            
            // Power button
            translate([
                -25 + 0.5*KINDLE_WIDTH,
                0.5*KINDLE_HEIGHT,
                WALL_THICKNESS,
            ])
            cuboid([
                16,
                20,
                KINDLE_MAX_THICKNESS,
            ], rounding=1);
            
            // USB socket
            translate([
                -25 + 0.5*KINDLE_WIDTH,
                -0.5*KINDLE_HEIGHT,
                WALL_THICKNESS,
            ])
            cuboid([
                16,
                20,
                KINDLE_MAX_THICKNESS,
            ], rounding=1);
        }
        
        // We raise the case where the Kindle is thin - up left
        translate([
            0.5*RAISED_WIDTH - 0.5*KINDLE_WIDTH - NEAR_ZERO + 4,
            0.475*KINDLE_HEIGHT - 0.5*RAISED_HEIGHT + NEAR_ZERO,
            0.5*RAISED_THICKNESS - 0.5*KINDLE_MAX_THICKNESS - NEAR_ZERO,
        ])
        cuboid([
            RAISED_WIDTH,
            RAISED_HEIGHT,
            RAISED_THICKNESS,
        ], rounding=0.4);

        // We raise the case where the Kindle is thin - down left    
        translate([
            0.5*RAISED_WIDTH - 0.5*KINDLE_WIDTH - NEAR_ZERO + 4,
            -0.475*KINDLE_HEIGHT + 0.5*RAISED_HEIGHT + NEAR_ZERO,
            0.5*RAISED_THICKNESS - 0.5*KINDLE_MAX_THICKNESS - NEAR_ZERO,
        ])
        cuboid([
            RAISED_WIDTH,
            RAISED_HEIGHT,
            RAISED_THICKNESS,
        ], rounding=0.4);
    }
}
if(TEST_MODEL){
    intersection(){
        case();
        // use this version to print the upper left part of the model
        // translate([-0.2*KINDLE_WIDTH, 0.26*KINDLE_HEIGHT, 0])
        // cube([1.5*RAISED_WIDTH, 0.5*KINDLE_HEIGHT, 2*KINDLE_MAX_THICKNESS], center = true);
        translate([-0.2*KINDLE_WIDTH - 0.5*RAISED_WIDTH, 0.4*KINDLE_HEIGHT, 0])
        cube([0.6*RAISED_WIDTH, 0.25*KINDLE_HEIGHT, 2*KINDLE_MAX_THICKNESS], center = true);
    }
}else{
    case();
}