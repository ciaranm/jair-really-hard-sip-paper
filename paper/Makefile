all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' -shell-escape paper

TABLES =

GRAPHS = gen-graph-phase-transition.pdf \
	 gen-graph-labels.pdf \
	 $(foreach ps, 10 20 30, \
		 gen-graph-non-induced-satisfiable-$(ps)-150.pdf \
		 gen-graph-non-induced-nodes-$(ps)-150.pdf \
		 gen-graph-lad-non-induced-nodes-$(ps)-150.pdf \
		 gen-graph-vf2-non-induced-nodes-$(ps)-150.pdf ) \
	 $(foreach ps, 10 14 15 16 20 30, \
		 gen-graph-induced-satisfiable-$(ps)-150.pdf \
		 gen-graph-induced-nodes-$(ps)-150.pdf \
		 gen-graph-lad-induced-nodes-$(ps)-150.pdf \
		 gen-graph-vf2-induced-nodes-$(ps)-150.pdf ) \
	 $(foreach ps, 10 14 15 16 20 30, \
		 gen-graph-induced-kappa-$(ps)-150.pdf \
		 gen-graph-induced-which-$(ps)-150.pdf ) \
	 $(foreach ps, 10 12 14 16 18 25, \
		 gen-graph-induced-satisfiable-$(ps)-75.pdf \
		 gen-graph-induced-nodes-$(ps)-75.pdf \
		 gen-graph-clasp-induced-nodes-$(ps)-75.pdf \
		 gen-graph-glucose-induced-nodes-$(ps)-75.pdf \
		 gen-graph-clique-induced-nodes-$(ps)-75.pdf \
		 gen-graph-gurobi-induced-nodes-$(ps)-75.pdf )

tables : $(TABLES)

graphs : $(GRAPHS)

define GRAPH_template =
gen-graph-$(1)-satisfiable-$(2)-$(3).pdf : graph-satisfiable-template.gnuplot
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "plotsize='$(4)'" -e "satlines=$(5)" -e "divide=$(6)" $$<
	latexmk -pdf gen-graph-$(1)-satisfiable-$(2)-$(3)

gen-graph-$(1)-nodes-$(2)-$(3).pdf : graph-nodes-template.gnuplot
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "plotsize='$(4)'" -e "divide=$(6)" $$<
	latexmk -pdf gen-graph-$(1)-nodes-$(2)-$(3)

gen-graph-$(1)-kappa-$(2)-$(3).pdf : graph-kappa-template.gnuplot
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "plotsize='$(4)'" -e "divide=$(6)" $$<
	latexmk -pdf gen-graph-$(1)-kappa-$(2)-$(3)

gen-graph-$(1)-which-$(2)-$(3).pdf : graph-which-template.gnuplot
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "plotsize='$(4)'" -e "divide=$(6)" $$<
	latexmk -pdf gen-graph-$(1)-which-$(2)-$(3)
endef

$(foreach ps, 10 20 30, \
    $(foreach f, non-induced lad-non-induced vf2-non-induced, \
    $(eval $(call GRAPH_template,$(f),$(ps),150,large,1,100))))

$(foreach ps, 10 14 15 16 20 30, \
    $(foreach f, induced lad-induced vf2-induced, \
    $(eval $(call GRAPH_template,$(f),$(ps),150,small,2,100))))

$(foreach ps, 10 12 14 16 18 25, \
    $(foreach f, induced clasp-induced glucose-induced clique-induced gurobi-induced, \
    $(eval $(call GRAPH_template,$(f),$(ps),75,small,0,50))))

gen-graph-%.pdf : graph-%.gnuplot
	gnuplot $<
	sed -i -e '19s/^\(\\path.*\)/\% \1/' gen-graph-$*.tex # epic haxx
	latexmk -pdf gen-graph-$*

