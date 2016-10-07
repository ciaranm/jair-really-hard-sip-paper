# vim: set et ft=gnuplot sw=4 :

outputfile="gen-graph-" . format . "-satisfiable-" . ps . ".tex"
proportionsat="data/ps" . ps . "-ts150." . format . ".proportion-sat.plot"
predictedline="data/ps" . ps . "-ts150." . format . ".predicted-line.plot"

if (plotsize eq 'large') { \
    if (ps == 30) { \
        set terminal tikz standalone color size 1.2in,1.0in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}' \
    } else { \
        set terminal tikz standalone color size 1.1in,1.0in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}' \
    }
} else { \
    if (ps == 30) { \
        set terminal tikz standalone color size 0.9in,0.7in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}' \
    } else { \
        set terminal tikz standalone color size 0.75in,0.7in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}' \
    } \
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
set cbtics 0.5

if (ps==30) set colorbox; else unset colorbox;

load "puyl.pal"

plot proportionsat u ($2/100):($1/100):($3) matrix w image notitle, \
    predictedline u 1:2 w line notitle lc "black", \
    predictedline u (columnhead(4) eq '' ? NaN :$4):(columnhead(5) eq '' ? NaN :$5) w line notitle lc "black"

