# vim: set et ft=gnuplot sw=4 :

set style line 102 lc rgb '#a0a0a0' lt 1 lw 1
set border ls 102
set colorbox border 102
set key textcolor rgb "black"
set tics textcolor rgb "black"
set label textcolor rgb "black"

outputfile="graph-" . format . "-satisfiable-" . ps . "-" . ts . ".tex"
proportionsat="../../experiments/flint-results/" . format . "-" . ps . "-" . ts . "-satisfiable.plot"
predictedline="../data/ps" . ps . "-ts" . ts . "." . format . ".predicted-line.plot"

if (ps == (ts == 150 ? 30 : 25)) { \
    set terminal tikz standalone color size 1.3in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath}' \
} else { \
    set terminal tikz standalone color size 0.9in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath}' \
}

load "../chromadiverge.pal"

set output outputfile

set lmargin screen 0
set tmargin screen 0.95
set bmargin screen 0.05
if (ps == (ts == 150 ? 30 : 25)) set rmargin at screen 0.9; else set rmargin at screen 1;

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square

set cbrange [0:1]
set cbtics out scale 0.5 nomirror offset -1
set cbtics 1 add ('all$^{\,}$' 1) add ('none' 0) add ('half' 0.5)

if (ps==(ts == 150 ? 30 : 25)) set colorbox; else unset colorbox;

if (satlines == 0) { \
    plot proportionsat u ($1/divide):($2/divide):($3) matrix w image notitle \
} else { if (satlines == 1) { \
    plot proportionsat u ($1/divide):($2/divide):($3) matrix w image notitle, \
        predictedline u 1:2 w line notitle lc "black" \
} else { \
    plot proportionsat u ($1/divide):($2/divide):($3) matrix w image notitle, \
        predictedline u 1:2 w line notitle lc "black", \
        predictedline u 4:5 w line notitle lc "black" \
} }

