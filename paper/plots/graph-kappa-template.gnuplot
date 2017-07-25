# vim: set et ft=gnuplot sw=4 :

outputfile="graph-" . format . "-kappa-" . ps . "-" . ts . ".tex"
nodesfile="../data/ps" . ps . "-ts" . ts . "." . format . ".kappa.plot"

if (ps == 30) { \
    set terminal tikz standalone color size 1.1in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \
} else { \
    set terminal tikz standalone color size 0.9in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \
}

load "../chromaconverge.pal"

set output outputfile

set lmargin screen 0
set tmargin screen 0.95
set bmargin screen 0.05
if (ps == 30) set rmargin at screen 0.9; else set rmargin at screen 1;

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1
set cbtics 1 add add ('$2$' 1.333) ('$3$' 1.666) ('${\ge}4$' 2)

set palette negative
unset format cb
if (ps==30) set colorbox; else unset colorbox;
set cbrange [0:2]

plot nodesfile u ($1/100):($2/100):($3<=1?$3:(1+(($3-1)/3))) matrix w image notitle