all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' -shell-escape paper

TABLES =

GRAPHS = gen-graph-sat.pdf gen-graph-non-induced.pdf gen-graph-induced.pdf gen-graph-phase-transition.pdf \
	 gen-graph-labels.pdf \
	 gen-graph-non-induced-satisfiable-10.pdf \
	 gen-graph-non-induced-satisfiable-20.pdf \
	 gen-graph-non-induced-satisfiable-30.pdf \
	 gen-graph-non-induced-nodes-10.pdf \
	 gen-graph-non-induced-nodes-20.pdf \
	 gen-graph-non-induced-nodes-30.pdf \
	 gen-graph-lad-non-induced-nodes-10.pdf \
	 gen-graph-lad-non-induced-nodes-20.pdf \
	 gen-graph-lad-non-induced-nodes-30.pdf \
	 gen-graph-vf2-non-induced-nodes-10.pdf \
	 gen-graph-vf2-non-induced-nodes-20.pdf \
	 gen-graph-vf2-non-induced-nodes-30.pdf

tables : $(TABLES)

graphs : $(GRAPHS)

gen-graph-non-induced-satisfiable-%.pdf : graph-non-induced-satisfiable-template.gnuplot
	gnuplot -e "ps=$*" $<
	latexmk -pdf gen-graph-non-induced-satisfiable-$*

gen-graph-non-induced-nodes-%.pdf : graph-non-induced-nodes-template.gnuplot
	gnuplot -e "ps=$*" -e "format='non-induced'" $<
	latexmk -pdf gen-graph-non-induced-nodes-$*

gen-graph-lad-non-induced-nodes-%.pdf : graph-non-induced-nodes-template.gnuplot
	gnuplot -e "ps=$*" -e "format='lad-non-induced'" $<
	latexmk -pdf gen-graph-lad-non-induced-nodes-$*

gen-graph-vf2-non-induced-nodes-%.pdf : graph-non-induced-nodes-template.gnuplot
	gnuplot -e "ps=$*" -e "format='vf2-non-induced'" $<
	latexmk -pdf gen-graph-vf2-non-induced-nodes-$*

gen-graph-%.pdf : graph-%.gnuplot
	gnuplot $<
	sed -i -e '19s/^\(\\path.*\)/\% \1/' gen-graph-$*.tex # epic haxx
	latexmk -pdf gen-graph-$*

