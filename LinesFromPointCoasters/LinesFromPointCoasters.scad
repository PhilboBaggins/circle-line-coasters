include <../common.scad>;

DEFAULT_NUM_LINES = 13;
DEFAULT_STARTING_POINT = [0, 0];
DEFAULT_SEED = 1; // Mostly used when previewing in OpenSCAD GUI

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

module LinesFromRandomPointCoaster2D(
    initialSeed = undef,
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    maxDist = radius - thickness;

    seed = (initialSeed == undef) ? DEFAULT_SEED : initialSeed;
    startingPoint = rands(-maxDist, maxDist, 2, seed);
    echo(startingPoint);
    LinesFromPointCoaster2D(startingPoint, numLines, radius, thickness, fn);
}

module LinesFromRandomPointCoaster3D(
    initialSeed = undef,
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    linear_extrude(thickness)
    LinesFromRandomPointCoaster2D(initialSeed, numLines, radius, thickness, fn);
}
