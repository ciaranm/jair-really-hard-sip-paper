# vim: set et ft=gnuplot sw=4 :

outputfile="graph-" . format . "-satisfiable-" . ps . "-l" . l . "-" . ts . ".tex"
proportionsat="../data/ps" . ps . "-ts" . ts . "-l" . l . "." . format . ".proportion-sat.plot"
predictedline="../data/ps" . ps . "-ts" . ts . "-l" . l . "." . format . ".predicted-line.plot"

if (l == 20) { \
    set terminal tikz standalone color size 1.1in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath}' \
} else { \
    set terminal tikz standalone color size 0.9in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath}' \
} \

load "../chromadiverge.pal"

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

if (l == 20) set colorbox; else unset colorbox;

if (satlines == 0) { \
    plot proportionsat u ($2/divide):($1/divide):($3) matrix w image notitle \
} else { if (satlines == 1) { \
    plot proportionsat u ($2/divide):($1/divide):($3) matrix w image notitle, \
        predictedline u 1:2 w line notitle lc "black" \
} else { \
    plot proportionsat u ($2/divide):($1/divide):($3) matrix w image notitle, \
        predictedline u 1:2 w line notitle lc "black", \
        predictedline u 4:5 w line notitle lc "black" \
} }

