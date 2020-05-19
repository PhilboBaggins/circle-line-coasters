
include <common.scad>;

DEFAULT_NUM_LINES = 30;

module RandoLineCoasterRound(
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    difference()
    {
        cylinder(r=radius, h=thickness, $fn = fn);
        translate([0, 0, -1])
        cylinder(r=radius - thickness, h=thickness+2, $fn = fn);
    }

    intersection()
    {
        cylinder(r=radius, h=thickness, $fn = fn);
        for (i = [0 : numLines - 1])
        {
            x = rands(-radius*2, radius*2, 1)[0];
            y = rands(-radius*2, radius*2, 1)[0];
            r = rands(0, 360, 1)[0];
            translate([x, y, 0])
            rotate([0, 0, r])
            cube([radius*10, thickness, thickness]);
        }
    }
}

RandoLineCoasterRound();
