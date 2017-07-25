# vim: set et ft=gnuplot sw=4 :

outputfile="graph-" . format . "-abortions-" . ps . "-l" . l . "-" . ts . ".tex"
nodesfile="../data/ps" . ps . "-ts" . ts . "-l" . l . "." . format . ".proportion-aborted.plot"

if (l == 20) { \
    set terminal tikz standalone color size 1.1in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \
} else { \
    set terminal tikz standalone color size 0.9in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \
} \

load "../chromasequencetoblack.pal"

set output outputfile

set lmargin screen 0
set tmargin screen 0.95
set bmargin screen 0.05
if (l == 20) set rmargin at screen 0.9; else set rmargin at screen 1;

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1
set cbtics 0.5

set palette positive
if (l == 20) set colorbox; else unset colorbox;
set cbrange [0:1]

plot nodesfile u ($2/divide):($1/divide):($3) matrix w image notitle

