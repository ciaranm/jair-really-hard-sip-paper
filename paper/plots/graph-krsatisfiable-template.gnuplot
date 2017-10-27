# vim: set et ft=gnuplot sw=4 :

set style line 102 lc rgb '#a0a0a0' lt 1 lw 1
set border ls 102
set colorbox border 102
set key textcolor rgb "black"
set tics textcolor rgb "black"
set label textcolor rgb "black"

outputfile="graph-" . format . "-kr-satisfiable-" . ps . "-" . ts . ".tex"
proportionsat="../../experiments/flint-results/" . format . "-" . ps . "-" . ts . "-kr-satisfiable.plot"

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
set xrange [0:1 + (0.5 / ps)]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1
set cbrange [0:1]
set cbtics 1 add ('all$^{\,}$' 1) add ('none' 0) add ('half' 0.5)

if (ps==30) set colorbox; else unset colorbox;

plot proportionsat u ($1/(ps - 1)):($2/(divide)):($3) matrix w image notitle

