# vim: set et ft=gnuplot sw=4 :

outputfile="gen-graph-" . format . "-kappa-" . ps . ".tex"
nodesfile="data/ps" . ps . "-ts150." . format . ".kappa.plot"

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
set cbtics 1 add ('${\ge}3$' 3)

load "ylgnbuwl.pal"
set palette negative
unset format cb
if (ps==30) set colorbox; else unset colorbox;
set cbrange [0:3]

plot nodesfile u ($1/100):($2/100):($3) matrix w image notitle
