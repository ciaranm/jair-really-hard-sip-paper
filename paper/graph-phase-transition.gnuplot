# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 5.6in,2.8in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}'
set output "gen-graph-phase-transition.tex"

load "puyl.pal"

set xrange [0:1]
set xlabel "Pattern density"
set ylabel "Search nodes"
set y2label "Proportion SAT" rotate by -90
set logscale y
set format y '$10^{%T}$'
set key outside right
set border 11
set grid
set xtics nomirror
set ytics nomirror
set y2tics 0.5 nomirror

plot \
    "<sed -e '1~25!d' data/ps20-ts150.non-induced.slice.plot" u ($4==0?$1:NaN):($5) w p notitle lc '#feb24c' pt 2 ps 0.7, \
    "<sed -e '1~25!d' data/ps20-ts150.non-induced.slice.plot" u ($4==1?$1:NaN):($5) w p notitle lc '#542788' pt 1 ps 0.7, \
    "data/ps20-ts150.non-induced.slice-averages.plot" u 1:3 w l ti 'Mean search' lc '#1d91c0' lw 3, \
    "" u (NaN):(NaN) w p pt 1 lc '#542788' ti "Satisfiable", \
    "" u (NaN):(NaN) w p pt 2 lc '#feb24c' ti "Unsatisfiable", \
    "" u (NaN):(NaN) w l lw 0 lc '#ffffff' ti "~", \
    "data/ps20-ts150.non-induced.slice-averages.plot" u 1:4 w l axes x1y2 ti 'Proportion SAT' lc '#0c2c84' lw 3

