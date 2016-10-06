# vim: set et ft=gnuplot sw=4 :

outputfile="gen-graph-non-induced-satisfiable-" . ps . ".tex"
proportionsat="data/ps" . ps . "-ts150.non-induced.proportion-sat.plot"
predictedline="data/ps" . ps . "-ts150.non-induced.predicted-line.plot"

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

if (ps==30) set colorbox; else unset colorbox;

load "puyl.pal"

plot proportionsat u ($2/100):($1/100):($3) matrix w image notitle, \
    predictedline u 1:2 w line notitle lc "black"

