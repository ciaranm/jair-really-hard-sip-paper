# vim: set et ft=gnuplot sw=4 :

set style line 102 lc rgb '#a0a0a0' lt 1 lw 1
set border ls 102
set colorbox border 102
set key textcolor rgb "black"
set tics textcolor rgb "black"
set label textcolor rgb "black"

outputfile="graph-" . format . "-which-" . ps . "-" . ts . ".tex"
nodesfile="../../experiments/flint-results/" . format . "-" . ps . "-" . ts . "-complement.plot"
linefile="../data/ps" . ps . "-ts" . ts . "." . format . ".actual-line.plot"

if (ps == 30) { \
    set terminal tikz standalone color size 1.3in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath}' \
} else { \
    set terminal tikz standalone color size 0.9in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath}' \
}

load "../chromadiverge.pal"

set output outputfile

set lmargin screen 0
set tmargin screen 0.95
set bmargin screen 0.05
if (ps == 30) set rmargin at screen 0.9; else set rmargin at screen 1;

unset xlabel
unset ylabel
set xrange [-0.005:1.005]
set noxtics
set yrange [-0.005:1.005]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1
set cbtics 1 add ('yes' 1) add ('no' -1) add ('~' 0)

set palette positive
unset format cb
if (ps==30) set colorbox; else unset colorbox;
set cbrange [-1:1]

plot nodesfile u ($1/100):($2/100):($3) matrix w image notitle, \
    linefile u ($1/50):($2/50) w line notitle lc "black", \
    linefile u ($4/50):($5/50) w line notitle lc "black", \
    x w l notitle lc "black" dt ".", 0.5 w line notitle lc "black" dt "."

