# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 5.7in,4.6in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}'
set output "gen-graph-labels.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 4,6

set lmargin 0.2
set rmargin 0.2

load "puyl.pal"
unset colorbox

set label 1 at screen -0.02, graph 0.5 center 'Satisfiable?' rotate by 90
set label 2 at screen 0.5, screen 1.05 center '$G(20, x) \hookrightarrow G(150, y)$'

set label 3 at graph 0.5, screen 0.98 center "No labels"
plot "data/ps20-ts150.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps20-ts150.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

unset label 1
unset label 2

set label 3 at graph 0.5, screen 0.98 center "2 labels"
plot "data/ps20-ts150-l2.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps20-ts150-l2.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

set label 3 at graph 0.5, screen 0.98 center "3 labels"
plot "data/ps20-ts150-l3.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps20-ts150-l3.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

set label 3 at graph 0.5, screen 0.98 center "5 labels"
plot "data/ps20-ts150-l5.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps20-ts150-l5.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black", \

set label 3 at graph 0.5, screen 0.98 center "10 labels"
plot "data/ps20-ts150-l10.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps20-ts150-l10.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black", \

set cbtics 0.5
set label 3 at graph 0.5, screen 0.98 center "20 labels"
plot "data/ps20-ts150-l20.non-induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps20-ts150-l20.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

unset label 3

load "ylgnbu.pal"
unset colorbox

set label 1 at screen -0.02, graph 0.5 center 'Glasgow' rotate by 90
set cbrange [2:5]

unset title
plot "data/ps20-ts150.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset label 1

unset title
plot "data/ps20-ts150-l2.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l3.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l5.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l10.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{5}$' 5)
set format cb '$10^{%.0f}$'

unset title
plot "data/ps20-ts150-l20.non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

set label 1 at screen -0.02, graph 0.5 center 'LAD' rotate by 90
set cbrange [2:5]

unset title
plot "data/ps20-ts150.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset label 1

unset title
plot "data/ps20-ts150-l2.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l3.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l5.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l10.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{5}$' 5)
set format cb '$10^{%.0f}$'

unset title
plot "data/ps20-ts150-l20.lad-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

set label 1 at screen -0.02, graph 0.5 center 'VF2' rotate by 90
set cbrange [2:5]

unset title
plot "data/ps20-ts150.vf2-non-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3)) matrix w image notitle

unset label 1

unset title
plot "data/ps20-ts150-l2.vf2-non-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l3.vf2-non-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l5.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3)) matrix w image notitle

unset title
plot "data/ps20-ts150-l10.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3)) matrix w image notitle

set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{5}$' 5)
set format cb '$10^{%.0f}$'

unset title
plot "data/ps20-ts150-l20.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3)) matrix w image notitle

