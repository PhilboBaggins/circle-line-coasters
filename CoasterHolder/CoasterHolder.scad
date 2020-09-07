include <../common.scad>;

DEFAULT_NUM_COASTERS = 15;

LOOSENESS_FACTOR_X = 2.0;
LOOSENESS_FACTOR_Y = 1.1;
SCREW_HOLE_RADIUS = 3.5 / 2; // 3.5 mm for M3 screw
BORDER_X = SCREW_HOLE_RADIUS * 5;
BORDER_Y = SCREW_HOLE_RADIUS * 5;

function calcSlotWidth(coasterThickness)
    = coasterThickness * LOOSENESS_FACTOR_X ;

function calcSizeX(coasterThickness, numCoasters)
    = 2 * BORDER_X + (2 * numCoasters - 1) * calcSlotWidth(coasterThickness);
function calcSizeY(coasterRadius)
    = 2 * BORDER_Y + coasterRadius*2 * LOOSENESS_FACTOR_Y;

function coasterPosX(x, coasterThickness)
    = BORDER_X + x * 2 * calcSlotWidth(coasterThickness);

function screwPosX1(sizeX) =         BORDER_X / 2;
function screwPosX2(sizeX) = sizeX - BORDER_X / 2;
function screwPosY1(sizeY) =         BORDER_Y / 2;
function screwPosY2(sizeY) = sizeY - BORDER_Y / 2;

module CoasterHolder2D_Bottom(numCoasters, coasterThickness, coasterRadius, fn)
{
    sizeX = calcSizeX(coasterThickness, numCoasters);
    sizeY = calcSizeY(coasterRadius);

    difference()
    {
        // Overall shape
        square([sizeX, sizeY]);

        // Screw holes
        translate([screwPosX1(sizeX), screwPosY1(sizeY)]) circle(SCREW_HOLE_RADIUS, $fn = fn);
        translate([screwPosX2(sizeX), screwPosY1(sizeY)]) circle(SCREW_HOLE_RADIUS, $fn = fn);
        translate([screwPosX1(sizeX), screwPosY2(sizeY)]) circle(SCREW_HOLE_RADIUS, $fn = fn);
        translate([screwPosX2(sizeX), screwPosY2(sizeY)]) circle(SCREW_HOLE_RADIUS, $fn = fn);
    }
}

module CoasterHolder2D_Top(numCoasters, coasterThickness, coasterRadius, fn)
{
    sizeX = calcSizeX(coasterThickness, numCoasters);
    sizeY = calcSizeY(coasterRadius);

    difference()
    {
        CoasterHolder2D_Bottom(numCoasters, coasterThickness, coasterRadius, fn);
        
        // Slots for coasters
        for (x = [0 : numCoasters - 1])
        {
            xPos = coasterPosX(x, coasterThickness);
            translate([xPos, BORDER_Y])
            square([coasterThickness * LOOSENESS_FACTOR_X, coasterRadius*2 * LOOSENESS_FACTOR_Y]);
        }
    }
}

module CoasterHolder2D(
    numCoasters = DEFAULT_NUM_COASTERS,
    coasterThickness = DEFAULT_THICKNESS,
    coasterRadius = DEFAULT_COASTER_RADIUS,
    fn = DEFAULT_FN)
{
    interPanelSpacing = 1;

    sizeX = calcSizeX(coasterThickness, numCoasters);
    sizeY = calcSizeY(coasterRadius);

    echo(str("Panel size = [", sizeX, " mm, ", sizeY, " mm]"));
    echo(str("Total size = [", sizeX, " mm, ", sizeY * 2 + interPanelSpacing, " mm]"));

    CoasterHolder2D_Bottom(numCoasters, coasterThickness, coasterRadius, fn);
    
    translate([0, sizeY + interPanelSpacing])
    CoasterHolder2D_Top(numCoasters, coasterThickness, coasterRadius, fn);
}

module CoasterHolder3D(
    numCoasters = DEFAULT_NUM_COASTERS,
    coasterThickness = DEFAULT_THICKNESS,
    coasterRadius = DEFAULT_COASTER_RADIUS,
    fn = DEFAULT_FN)
{
    sizeX = calcSizeX(coasterThickness, numCoasters);
    sizeY = calcSizeY(coasterRadius);

    color("red")
    linear_extrude(coasterThickness)
    CoasterHolder2D_Bottom(numCoasters, coasterThickness, coasterRadius, fn);

    color("blue")
    translate([0, 0, coasterRadius])
    linear_extrude(coasterThickness)
    CoasterHolder2D_Top(numCoasters, coasterThickness, coasterRadius, fn);

    // Slots for coasters
    for (x = [0 : numCoasters - 1])
    {
        xPos = coasterPosX(x, coasterThickness) + coasterThickness * LOOSENESS_FACTOR_X / 4;
        yPos = BORDER_Y + coasterRadius * LOOSENESS_FACTOR_Y;
        zPos = coasterRadius + coasterThickness;

        translate([xPos, yPos, zPos])
        rotate([0, 90, 0])
        #cylinder(r = coasterRadius, h = coasterThickness, $fn = fn);
    }

    // Stand-offs
    zPos = coasterThickness;
    translate([screwPosX1(sizeX), screwPosY1(sizeY), zPos]) cylinder(r = SCREW_HOLE_RADIUS, h = coasterRadius, $fn = fn);
    translate([screwPosX2(sizeX), screwPosY1(sizeY), zPos]) cylinder(r = SCREW_HOLE_RADIUS, h = coasterRadius, $fn = fn);
    translate([screwPosX1(sizeX), screwPosY2(sizeY), zPos]) cylinder(r = SCREW_HOLE_RADIUS, h = coasterRadius, $fn = fn);
    translate([screwPosX2(sizeX), screwPosY2(sizeY), zPos]) cylinder(r = SCREW_HOLE_RADIUS, h = coasterRadius, $fn = fn);
}

//CoasterHolder2D();
//CoasterHolder3D();
