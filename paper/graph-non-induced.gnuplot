# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 3.6in,4.8in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}'
set output "gen-graph-non-induced.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 4,3

set lmargin 0.2
set rmargin 0.2

load "puyl.pal"
unset colorbox

set label 1 at screen 0, graph 0.5 center 'Satisfiable?' rotate by 90

set label 2 at graph 0.5, screen 1 center "$G(10,x){\\rightarrowtail}G(150,y)$"
set cbtics 0.5
plot "data/ps10-ts150.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps10-ts150.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

unset label 1

set label 2 at graph 0.5, screen 1 center "$G(20,x){\\rightarrowtail}G(150,y)$"
set cbtics 0.5
plot "data/ps20-ts150.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps20-ts150.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

set label 2 at graph 0.5, screen 1 center "$G(30,x){\\rightarrowtail}G(150,y)$"
plot "data/ps30-ts150.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps30-ts150.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

load "ylgnbu.pal"
set palette positive
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:8]

set label 1 at screen 0, graph 0.5 center 'Glasgow' rotate by 90
unset label 2

plot "data/ps10-ts150.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps20-ts150.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set label 1 at screen 0, graph 0.5 center 'LAD' rotate by 90

set notitle
plot "data/ps10-ts150.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps20-ts150.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
set notitle
plot "data/ps30-ts150.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set label 1 at screen 0, graph 0.5 center 'VF2' rotate by 90

set notitle
plot "data/ps10-ts150.vf2-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps20-ts150.vf2-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.vf2-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

