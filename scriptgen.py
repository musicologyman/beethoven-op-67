from math import ceil as ceiling
from collections import namedtuple

formatstring = "lilypond --png -dresolution=1200 -danti-alias-factor=1 -e '(define skipNoteColor (rgb-color {0:d} {0:d} {0:d}))' --output=./png-temp/img{1:02} beethoven-op-67-i-ex-1c.ly"

def frange(lowerbound, upperbound, increment):
    iterationcount = 1 + ceiling((upperbound - lowerbound) / increment)
    for i in range(0, iterationcount):
        yield lowerbound + float(i) * increment


RGBColor = namedtuple("RGBColor", "r g b")

r1, g1 = 0.33, 0.67
ri, gi = 1 - r1, 1 - g1
ir, ig = ri / 40, gi / 40

colors1 = (RGBColor(r = r1 + f * ir, g = g1 + f * ig, b = 1.0) for f in frange (0.0, 1.0, 0.025))

colors2 = (RGBColor(r = 0.33 * f, g = 0.67 * f, b = f) for f in frange(0.4, 1.0, 0.01))

for c in colors1: print(c)
for c in colors2: print(c)
