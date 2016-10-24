# vim: set et ft=gnuplot sw=4 :

outputfile="gen-graph-" . format . "-kr-nodes-" . ps . "-" . ts . ".tex"
nodesfile="data/ps" . ps . "-ts" . ts . "-kr." . format . ".average-nodes.plot"

if (ps == 30) { \
    set terminal tikz standalone color size 1.1in,0.9in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}' \
} else { \
    set terminal tikz standalone color size 0.9in,0.9in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}' \
}

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
set cbtics 2 add ('fail' 8)

load "wylgnbu.pal"
set palette positive
set format cb '$10^{%.0f}$'
if (ps==30) set colorbox; else unset colorbox;
set cbrange [0:8]

plot nodesfile u ($2/(ps-1)):($1/divide):(log10($3+1)) matrix w image notitle
