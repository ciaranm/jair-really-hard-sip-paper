# vim: set et ft=gnuplot sw=4 :

set border lc 'red'

outputfile="graph-" . format . "-kr-nodes-" . ps . "-" . ts . ".tex"
nodesfile="../../experiments/flint-results/" . format . "-" . ps . "-" . ts . "-kr-nodes.plot"

if (ps == 30) { \
    set terminal tikz standalone color size 1.1in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \
} else { \
    set terminal tikz standalone color size 0.9in,0.9in font '\footnotesize' preamble '\usepackage{microtype,amssymb,amsmath,times}' \
}

load "../chromasequencefromwhitetoblack.pal"

set output outputfile

set datafile missing "fail"

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

set palette positive
set format cb '$10^{%.0f}$'
if (ps==30) set colorbox; else unset colorbox;
set cbrange [0:8]

plot nodesfile u ($1/(ps-1)):($2/divide):($3>=0?log10($3+1):1e10) matrix w image notitle
