# vim: set et ft=gnuplot sw=4 :

set style line 102 lc rgb '#a0a0a0' lt 1 lw 1
set border ls 102
set colorbox border 102
set key textcolor rgb "black"
set tics textcolor rgb "black"
set label textcolor rgb "black"

set terminal tikz standalone color size 2.6in,2.2in font '\footnotesize' preamble '\usepackage{microtype}'
set output "biiiig-data-ppigo.tex"

load "../chroma.pal"

set xrange [0:30]
set xlabel "Recursive calls"
set ylabel "Instances solved"
set yrange [0:100]
set key Right at screen 0.465, screen 0.458
set border 3
set grid ls 101
set xtics nomirror
set ytics nomirror
set key off
set title "PPI"

plot \
    "<cut -d' ' -f6 ../data/Xppigo-mysip.txt" u 1:(1) smooth cumulative w l ls 1 lw 2

