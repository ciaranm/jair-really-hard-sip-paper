# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 5in,3in font '\footnotesize' preamble '\usepackage{microtype,times}'
set output "skewed.tex"

load "../chroma.pal"

set xrange [1:1e6]
set xlabel "Runtime (ms)"
set ylabel "Instances solved"
set yrange [0:1000]
set logscale x
set format x '$10^{%T}$'
set key Right at screen 0.465, screen 0.458
set border 3
set grid ls 101
set xtics nomirror
set ytics nomirror

plot \
    "../data/skewed-glasgow-10-0.2-10-0.1-30---50-0.2-50-0.3-30-xf-all" u 3:(strcol(1) eq "extra" ? 0 : 1) smooth cumulative w l ls 1 lw 2 ti "Glasgow", \
    "<cut -d';' -f4 ../data/skewed-lad-10-0.2-10-0.1-30---50-0.2-50-0.3-30-xl-all | cut -d' ' -f2" u ($1*1000):(1) smooth cumulative w l ls 3 lw 2 ti "LAD", \
    "../data/skewed-vf-10-0.2-10-0.1-30---50-0.2-50-0.3-30-xf-all" u (strcol(1) eq "aborted" ? 1e6 : $3):(strcol(1) eq "aborted" ? 0 : 1) smooth cumulative w l ls 4 lw 2 ti 'VF2{$\leftrightarrow$}', \
    "../data/skewed-vf-10-0.2-10-0.1-30---50-0.2-50-0.3-30-xl-all" u (strcol(1) eq "aborted" ? 1e6 : $3):(strcol(1) eq "aborted" ? 0 : 1) smooth cumulative w l ls 6 lw 2 ti "VF2"

