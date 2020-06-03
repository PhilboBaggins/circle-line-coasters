
include <common.scad>;

DEFAULT_NUM_LINES = 30;
DEFAULT_SEED = 1; // Mostly used when previewing in OpenSCAD GUI

module RandoLineCoasterRound2D(
    initialSeed = undef,
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    seed = (initialSeed == undef) ? DEFAULT_SEED : initialSeed;
    seeds = rands(0, 1, 2 * numLines, seed);

    // Main coaster outline
    difference()
    {
        circle($fn = fn, r = radius);
        circle($fn = fn, r = radius - thickness);
    }

    // Random lines
    intersection()
    {
        circle($fn = fn, r = radius);
        for (i = [0 : numLines - 1])
        {
            s1 = seeds[i * 2 + 0];
            s2 = seeds[i * 2 + 1];
            xy = rands(radius * -2, radius * 2, 2, s1);
            r = rands(0, 360, 1, s2)[0];
            translate(xy)
            rotate([0, 0, r])
            square([radius * 10, thickness]);
        }
    }
}

module RandoLineCoasterRound3D(
    initialSeed = undef,
    numLines = DEFAULT_NUM_LINES,
    radius = DEFAULT_COASTER_RADIUS,
    thickness = DEFAULT_THICKNESS,
    fn = DEFAULT_FN)
{
    linear_extrude(thickness)
    RandoLineCoasterRound2D(initialSeed, numLines, radius, thickness, fn);
}
