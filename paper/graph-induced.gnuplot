# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 5.7in,6.6in font '\scriptsize' preamble '\usepackage{microtype,amssymb,amsmath}'
set output "gen-graph-induced.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 6,6

set rmargin 0.2
set lmargin 0.2

set label 1 at screen 0, graph 0.5 center 'Satisfiable?' rotate by 90

load "puyl.pal"
unset colorbox

set label 2 at graph 0.5, screen 1 center "$G(10,x){\\hookrightarrow}G(150,y)$"
set cbtics 0.5
plot "data/ps10-ts150.induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps10-ts150.induced.predicted-line.plot" u 1:2 w line notitle lc "black", \
    "data/ps10-ts150.induced.predicted-line.plot" u 4:5 w line notitle lc "black"

unset label 1

set label 2 at graph 0.5, screen 1 center "$G(14,x){\\hookrightarrow}G(150,y)$"
set cbtics 0.5
plot "data/ps14-ts150.induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps14-ts150.induced.predicted-line.plot" u 1:2 w line notitle lc "black", \
    "data/ps14-ts150.induced.predicted-line.plot" u 4:5 w line notitle lc "black"

set label 2 at graph 0.5, screen 1 center "$G(15,x){\\hookrightarrow}G(150,y)$"
set cbtics 0.5
plot "data/ps15-ts150.induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps15-ts150.induced.predicted-line.plot" u 1:2 w line notitle lc "black", \
    "data/ps15-ts150.induced.predicted-line.plot" u 4:5 w line notitle lc "black"

set label 2 at graph 0.5, screen 1 center "$G(16,x){\\hookrightarrow}G(150,y)$"
set cbtics 0.5
plot "data/ps16-ts150.induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps16-ts150.induced.predicted-line.plot" u 1:2 w line notitle lc "black", \
    "data/ps16-ts150.induced.predicted-line.plot" u 4:5 w line notitle lc "black"

set label 2 at graph 0.5, screen 1 center "$G(20,x){\\hookrightarrow}G(150,y)$"
set cbtics 0.5
plot "data/ps20-ts150.induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps20-ts150.induced.predicted-line.plot" u 1:2 w line notitle lc "black", \
    "data/ps20-ts150.induced.predicted-line.plot" u 4:5 w line notitle lc "black"

set label 2 at graph 0.5, screen 1 center "$G(30,x){\\hookrightarrow}G(150,y)$"
set cbtics 0.5
plot "data/ps30-ts150.induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "data/ps30-ts150.induced.predicted-line.plot" u 1:2 w line notitle lc "black", \
    "data/ps30-ts150.induced.predicted-line.plot" u 4:5 w line notitle lc "black"

unset label 2

load "ylgnbu.pal"
set palette positive
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:8]

set label 1 at screen 0, graph 0.5 center 'Glasgow' rotate by 90

set notitle
plot "data/ps10-ts150.induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps14-ts150.induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps15-ts150.induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps16-ts150.induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps20-ts150.induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set label 1 at screen 0, graph 0.5 center 'LAD' rotate by 90

set notitle
plot "data/ps10-ts150.lad-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps14-ts150.lad-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps15-ts150.lad-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps16-ts150.lad-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps20-ts150.lad-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.lad-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set label 1 at screen 0, graph 0.5 center 'VF2' rotate by 90

set notitle
plot "data/ps10-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps14-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps15-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps16-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps20-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

load "puyl.pal"
unset colorbox
set notitle
set cbrange [0:1]
unset format cb

# set label 1 at screen 0, graph 0.5 center 'Non-induced satisfiability' rotate by 90
# set label 2 at screen 0, graph 0.5 center 'mirrored along $p_d=t_d$' rotate by 90 offset character 1.2, character 0
# 
# set cbtics 0.5
# plot "data/ps10-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle
# 
# unset label 1
# unset label 2
# 
# set cbtics 0.5
# plot "data/ps14-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle
# 
# set cbtics 0.5
# plot "data/ps15-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle
# 
# set cbtics 0.5
# plot "data/ps16-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle
# 
# set cbtics 0.5
# plot "data/ps20-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle
# 
# set colorbox
# 
# set cbtics 0.5
# plot "data/ps30-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

load "ylgnbuwl.pal"
set palette negative
unset colorbox
set notitle
set cbrange [0:3]
unset format cb

set label 1 at screen 0, graph 0.5 center 'Constrainedness' rotate by 90

set cbtics 0.5
plot "data/ps10-ts150.induced.kappa.plot" u ($1/100):($2/100):($3) matrix w image notitle

unset label 1

plot "data/ps14-ts150.induced.kappa.plot" u ($1/100):($2/100):($3) matrix w image notitle

plot "data/ps15-ts150.induced.kappa.plot" u ($1/100):($2/100):($3) matrix w image notitle

plot "data/ps16-ts150.induced.kappa.plot" u ($1/100):($2/100):($3) matrix w image notitle

plot "data/ps20-ts150.induced.kappa.plot" u ($1/100):($2/100):($3) matrix w image notitle

set cbtics 1 add ('$\ge4$' 4)
plot "data/ps30-ts150.induced.kappa.plot" u ($1/100):($2/100):($3) matrix w image notitle

unset colorbox
set notitle

set cbrange [-10:10]
set cbtics 10 add ("always" 10) ("never" -10) ("neutral" 0)

load "puyl.pal"
set palette positive

set label 1 at screen 0, graph 0.5 center 'Complement better?' rotate by 90

plot "data/ps10-ts150.induced-which-counts-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps10-ts150.induced.actual-line.plot" u ($1/50):($2/50) w line notitle lc "black", \
    "data/ps10-ts150.induced.actual-line.plot" u ($4/50):($5/50) w line notitle lc "black", \
    x w l notitle lc "black" dt ".", 0.5 w line notitle lc "black" dt "."

unset label 1
unset label 2

plot "data/ps14-ts150.induced-which-counts-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps14-ts150.induced.actual-line.plot" u ($1/50):($2/50) w line notitle lc "black", \
    "data/ps14-ts150.induced.actual-line.plot" u ($4/50):($5/50) w line notitle lc "black", \
    x w l notitle lc "black" dt ".", 0.5 w line notitle lc "black" dt "."

plot "data/ps15-ts150.induced-which-counts-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps15-ts150.induced.actual-line.plot" u ($1/50):($2/50) w line notitle lc "black", \
    "data/ps15-ts150.induced.actual-line.plot" u ($4/50):($5/50) w line notitle lc "black", \
    x w l notitle lc "black" dt ".", 0.5 w line notitle lc "black" dt "."

plot "data/ps16-ts150.induced-which-counts-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps16-ts150.induced.actual-line.plot" u ($1/50):($2/50) w line notitle lc "black", \
    "data/ps16-ts150.induced.actual-line.plot" u ($4/50):($5/50) w line notitle lc "black", \
    x w l notitle lc "black" dt ".", 0.5 w line notitle lc "black" dt "."

plot "data/ps20-ts150.induced-which-counts-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps20-ts150.induced.actual-line.plot" u ($1/50):($2/50) w line notitle lc "black", \
    "data/ps20-ts150.induced.actual-line.plot" u ($4/50):($5/50) w line notitle lc "black", \
    x w l notitle lc "black" dt ".", 0.5 w line notitle lc "black" dt "."

plot "data/ps30-ts150.induced-which-counts-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps30-ts150.induced.actual-line.plot" u ($1/50):($2/50) w line notitle lc "black", \
    "data/ps30-ts150.induced.actual-line.plot" u ($4/50):($5/50) w line notitle lc "black", \
    x w l notitle lc "black" dt ".", 0.5 w line notitle lc "black" dt "."

