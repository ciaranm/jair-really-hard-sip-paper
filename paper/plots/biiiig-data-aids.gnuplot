# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 2.6in,2.2in font '\footnotesize' preamble '\usepackage{microtype,times}'
set output "biiiig-data-aids.tex"

load "../chroma.pal"

set xrange [0:60]
set xlabel "Recursive calls"
set ylabel "Instances solved (1000s)"
set yrange [0:240]
set key Right at screen 0.465, screen 0.458
set border 3
set grid ls 101
set xtics nomirror
set ytics nomirror
set key off
set title "AIDS"
set ytics add ("$240$" 240)

plot \
    "<cut -d' ' -f6 ../data/Xaids40000-mysip.txt" u 1:(1e-3) smooth cumulative w l ls 1 lw 2

