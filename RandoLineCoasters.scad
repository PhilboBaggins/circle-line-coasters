
$fn = 64;

module RandoLineCoasterRound(radius = 30, thickness = 3, numLines = 30)
{
    difference()
    {
        cylinder(r=radius, h=thickness);
        translate([0, 0, -1])
        cylinder(r=radius - thickness, h=thickness+2);
    }

    intersection()
    {
        cylinder(r=radius, h=thickness);
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
