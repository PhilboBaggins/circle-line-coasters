
include <common.scad>;

DEFAULT_NUM_LINES = 30;

module RandoLineCoasterRound2D(
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    difference()
    {
        circle($fn = fn, r = radius);
        circle($fn = fn, r = radius - thickness);
    }

    intersection()
    {
        circle(r = radius, $fn = fn);
        for (i = [0 : numLines - 1])
        {
            x = rands(radius * -2, radius * 2, 1)[0];
            y = rands(radius * -2, radius * 2, 1)[0];
            r = rands(0, 360, 1)[0];
            translate([x, y])
            rotate([0, 0, r])
            square([radius * 10, thickness]);
        }
    }
}

module RandoLineCoasterRound3D(
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    linear_extrude(thickness)
    RandoLineCoasterRound2D(numLines, radius, thickness, fn);
}

RandoLineCoasterRound2D();
//RandoLineCoasterRound3D();
