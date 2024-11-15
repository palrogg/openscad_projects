include <BOSL2/std.scad>
include <grove_sht35.scad>

union(){
    plate_and_cylinders();
    for (i=[0:180:270]) {
        rotate([0, 0, i]) {
            for(factor=[-1:2:1]){
                translate([factor*plate_width*0.4, plate_length/2 + 0.61, 9.7]){
                    cuboid([6, 4, 20], rounding=0.4, trimcorners=false);
                }
            }
        }
    }
}