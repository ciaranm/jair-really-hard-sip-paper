all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' -shell-escape paper

TABLES =

GRAPHS = gen-graph-sat.pdf gen-graph-phase-transition.pdf \
	 gen-graph-labels.pdf \
	 $(foreach ps, 10 20 30, \
		 gen-graph-non-induced-satisfiable-$(ps).pdf \
		 gen-graph-non-induced-nodes-$(ps).pdf \
		 gen-graph-lad-non-induced-nodes-$(ps).pdf \
		 gen-graph-vf2-non-induced-nodes-$(ps).pdf ) \
	 $(foreach ps, 10 14 15 16 20 30, \
		 gen-graph-induced-satisfiable-$(ps).pdf \
		 gen-graph-induced-nodes-$(ps).pdf \
		 gen-graph-lad-induced-nodes-$(ps).pdf \
		 gen-graph-vf2-induced-nodes-$(ps).pdf ) \
	 $(foreach ps, 10 14 15 16 20 30, \
		 gen-graph-induced-kappa-$(ps).pdf \
		 gen-graph-induced-which-$(ps).pdf )

tables : $(TABLES)

graphs : $(GRAPHS)

define GRAPH_template =
gen-graph-$(1)-satisfiable-$(2).pdf : graph-satisfiable-template.gnuplot
	gnuplot -e "ps=$(2)" -e "format='$(1)'" -e "plotsize='$(3)'" $$<
	latexmk -pdf gen-graph-$(1)-satisfiable-$(2)

gen-graph-$(1)-nodes-$(2).pdf : graph-nodes-template.gnuplot
	gnuplot -e "ps=$(2)" -e "format='$(1)'" -e "plotsize='$(3)'" $$<
	latexmk -pdf gen-graph-$(1)-nodes-$(2)

gen-graph-$(1)-kappa-$(2).pdf : graph-kappa-template.gnuplot
	gnuplot -e "ps=$(2)" -e "format='$(1)'" -e "plotsize='$(3)'" $$<
	latexmk -pdf gen-graph-$(1)-kappa-$(2)

gen-graph-$(1)-which-$(2).pdf : graph-which-template.gnuplot
	gnuplot -e "ps=$(2)" -e "format='$(1)'" -e "plotsize='$(3)'" $$<
	latexmk -pdf gen-graph-$(1)-which-$(2)
endef

$(foreach ps, 10 20 30, \
    $(foreach f, non-induced lad-non-induced vf2-non-induced, \
    $(eval $(call GRAPH_template,$(f),$(ps),large))))

$(foreach ps, 10 14 15 16 20 30, \
    $(foreach f, induced lad-induced vf2-induced, \
    $(eval $(call GRAPH_template,$(f),$(ps),small))))

gen-graph-%.pdf : graph-%.gnuplot
	gnuplot $<
	sed -i -e '19s/^\(\\path.*\)/\% \1/' gen-graph-$*.tex # epic haxx
	latexmk -pdf gen-graph-$*

