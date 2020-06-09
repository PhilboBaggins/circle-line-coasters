#!/usr/bin/env python
# -*- coding: utf8 -*-

from __future__ import print_function
import os
import sys
import textwrap
from six.moves import range
import decimal

__version__ = '0.1.0'

IMPORT_FILE = 'LinesFromPointCoasters.scad'

# https://stackoverflow.com/questions/7267226/range-for-floats
def drange(x, y, jump):
    while x < y:
        yield float(x)
        x += decimal.Decimal(jump)


def genOpenScadSource(importFilePath, startingPoint, withBorder):
    return textwrap.dedent('''
    use <%s>;

    startingPoint = [%s, 0];
    withBoarder = %s;
    LinesFromPointCoaster2D(startingPoint=startingPoint, withBoarder=withBoarder);
    ''' % (importFilePath, startingPoint, "true" if withBorder else "false")).strip()


def getFileName(outDir, startingPoint, withBorder):
    border = "with-border" if withBorder else "without-border"
    fileName = 'lines-from-point-coaster-%s-%s' % (border, startingPoint)
    fileName = fileName.replace('.', '-') + '.scad'
    return fileName


def main(start, end, increment, outDir, verbose=0):
    if not os.path.exists(outDir):
        if verbose > 0:
            print('Creating output directory:', outDir)
        os.mkdir(outDir)

    thisFilePath = os.path.abspath(__file__)
    thisFileDir = os.path.dirname(thisFilePath)
    importFilePath= os.path.join(thisFileDir, IMPORT_FILE)

    os.chdir(outDir)

    # Get the path to the import file relative to the output dir, so that OpenSCAD can import it properly
    importFilePath = os.path.relpath(importFilePath)

    for x in drange(start, end, increment):
        if verbose > 0:
            print('Creating OpenSCAD source code files for seed', x)
        for border in [True, False]:
            sourceCode = genOpenScadSource(importFilePath, x, border)
            filePath = getFileName(outDir, x, border)
            with open(filePath, 'w+') as f:
                f.write(sourceCode)


if __name__ == '__main__':
    from argparse import ArgumentParser
    parser = ArgumentParser()
    parser.add_argument('--version',
                        action='version',
                        version='%(prog)s ' + __version__)
    parser.add_argument('-v', '--verbose',
                        action='count',
                        dest='verbose',
                        default=0,
                        help='Verbose output')
    parser.add_argument('-s', '--start-num',
                        action='store',
                        dest='start',
                        default=0,
                        help='Start number')
    parser.add_argument('-e', '--end-num',
                        action='store',
                        dest='end',
                        default=110,
                        help='End number')
    parser.add_argument('-i', '--increment',
                        action='store',
                        dest='increment',
                        default=1,
                        help='Incredment')
    parser.add_argument('-o', '--output-dir',
                        action='store',
                        dest='outDir',
                        default='exports',
                        help='Output directory')

    args = parser.parse_args()

    try:
        main(decimal.Decimal(args.start), decimal.Decimal(args.end), decimal.Decimal(args.increment), args.outDir, verbose=args.verbose)
    except KeyboardInterrupt:
        print('Keyboard interrupt received, exiting...', file=sys.stderr)
