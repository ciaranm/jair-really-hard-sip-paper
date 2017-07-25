# vim: set et ft=gnuplot sw=4 :

outputfile="graph-" . format . "-abortions-" . ps . "-" . ts . ".tex"
nodesfile="../data/ps" . ps . "-ts" . ts . "." . format . ".proportion-aborted.plot"

set terminal tikz standalone color size 0.9in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \

set output outputfile

load "../chromasequencetoblack.pal"

set lmargin screen 0
set tmargin screen 0.95
set bmargin screen 0.05
set rmargin at screen 1

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
unset colorbox
set cbrange [0:1]

plot nodesfile u ($2/divide):($1/divide):($3) matrix w image notitle

