include <../common.scad>;

DEFAULT_NUM_LINES = 23;
DEFAULT_STARTING_POINT = [0, 0];

module LinesFromPointCoaster2D(
    startingPoint = DEFAULT_STARTING_POINT,
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    // Main coaster outline
    difference()
    {
        circle($fn = fn, r = radius);
        circle($fn = fn, r = radius - thickness);
    }

    // Lines radiating out from the starting point
    intersection()
    {
        circle($fn = fn, r = radius);

        translate(startingPoint)
        for (i = [0 : numLines - 1])
        {
            r = 360 / numLines * i;
            rotate([0, 0, r])
            square([radius * 10, thickness], center=true);
        }
    }
}

module LinesFromPointCoaster3D(
    startingPoint = DEFAULT_STARTING_POINT,
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    linear_extrude(thickness)
    RandoLineCoasterRound2D(startingPoint, numLines, radius, thickness, fn);
}

module LinesFromPointCoaster2D_Array(
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    maxDist = radius - thickness;
    for (x = [-maxDist : maxDist])
    {
        translate([x * radius * 2, 0])
        LinesFromPointCoaster2D([x, 0], numLines, radius, thickness, fn);
            
        translate([x * radius * 2, radius * -2])
        text(str(x));
    }
}

module LinesFromPointCoaster3D_Array(
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    linear_extrude(thickness)
    LinesFromPointCoaster2D_Array(numLines, radius, thickness, fn);
}
