# vim: set et ft=gnuplot sw=4 :

outputfile="gen-graph-" . format . "-nodes-" . ps . ".tex"
nodesfile="data/ps" . ps . "-ts150." . format . ".average-nodes.plot"

set terminal tikz standalone color size 1.3in,1.2in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}'
set output outputfile

set tmargin screen 0.9
set bmargin screen 0.02
set rmargin screen 0.98

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

load "ylgnbu.pal"
set palette positive
set format cb '$10^{%.0f}$'
if (ps==30) set colorbox; else unset colorbox;
set cbrange [2:8]

plot nodesfile u ($2/100):($1/100):(log10($3+1)) matrix w image notitle
