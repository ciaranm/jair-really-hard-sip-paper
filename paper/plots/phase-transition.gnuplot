# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 5in,3in font '\footnotesize' preamble '\usepackage{microtype,times}'
set output "phase-transition.tex"

load "../chroma.pal"

set xrange [0:1]
set xlabel "Pattern density"
set ylabel "Search nodes"
set logscale y
set format y '$10^{%T}$'
set key Right at screen 0.40, screen 0.91
set border 3
set grid ls 101
set xtics nomirror
set ytics nomirror

plot \
    "<sed -e '1~25!d' ../data/ps20-ts150.non-induced.slice.plot" u ($4==0?$1:NaN):($5) w p ls 2 pt 2 ps 0.8 ti "Unsatisfiable", \
    "<sed -e '1~25!d' ../data/ps20-ts150.non-induced.slice.plot" u ($4==1?$1:NaN):($5) w p ls 5 pt 6 ps 0.8 ti "Satisfiable", \
    "../data/ps20-ts150.non-induced.slice-averages.plot" u 1:3 w l lc -1 lw 2 ti "Mean search"

