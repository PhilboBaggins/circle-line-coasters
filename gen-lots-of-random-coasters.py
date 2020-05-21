#!/usr/bin/env python
# -*- coding: utf8 -*-

from __future__ import print_function
import os
import sys
import textwrap
from six.moves import range
import decimal

__version__ = '0.1.0'

IMPORT_FILE = 'RandoLineCoasters.scad'

# https://stackoverflow.com/questions/7267226/range-for-floats
def drange(x, y, jump):
    while x < y:
        yield float(x)
        x += decimal.Decimal(jump)


def genOpenScadSource(importFilePath, initialSeed):
    return textwrap.dedent('''
    use <%s>;

    initialSeed = %s;
    RandoLineCoasterRound2D(initialSeed);
    ''' % (importFilePath, initialSeed)).strip()


def getFileName(outDir, initialSeed):
    fileName = 'random-line-coaster-%s' % initialSeed
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
    print(importFilePath)

    for x in drange(start, end, increment):
        if verbose > 0:
            print('Creating OpenSCAD source code file for seed', x)
        sourceCode = genOpenScadSource(importFilePath, x)
        filePath = getFileName(outDir, x)
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
                        default=100,
                        help='End number')
    parser.add_argument('-i', '--increment',
                        action='store',
                        dest='increment',
                        default=1,
                        help='Incredment')
    parser.add_argument('-o', '--output-dir',
                        action='store',
                        dest='outDir',
                        default='random-line-coasters',
                        help='Output directory')

    args = parser.parse_args()

    try:
        main(decimal.Decimal(args.start), decimal.Decimal(args.end), decimal.Decimal(args.increment), args.outDir, verbose=args.verbose)
    except KeyboardInterrupt:
        print('Keyboard interrupt received, exiting...', file=sys.stderr)
