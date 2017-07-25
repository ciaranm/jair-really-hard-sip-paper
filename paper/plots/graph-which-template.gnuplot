# vim: set et ft=gnuplot sw=4 :

outputfile="graph-" . format . "-which-" . ps . "-" . ts . ".tex"
nodesfile="../data/ps" . ps . "-ts" . ts . "." . format . "-which-counts-rev-both.plot"
linefile="../data/ps" . ps . "-ts" . ts . "." . format . ".actual-line.plot"

if (ps == 30) { \
    set terminal tikz standalone color size 1.1in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \
} else { \
    set terminal tikz standalone color size 0.9in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \
}

load "../chromadiverge.pal"

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
set cbtics 10 add ('yes' 10) add ('no' -10) add ('~' 0)

set palette positive
unset format cb
if (ps==30) set colorbox; else unset colorbox;
set cbrange [-10:10]

plot nodesfile u ($2/100):($1/100):($3) matrix w image notitle, \
    linefile u ($1/50):($2/50) w line notitle lc "black", \
    linefile u ($4/50):($5/50) w line notitle lc "black", \
    x w l notitle lc "black" dt ".", 0.5 w line notitle lc "black" dt "."

