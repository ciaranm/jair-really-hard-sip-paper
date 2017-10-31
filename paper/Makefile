all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' -shell-escape paper

GRAPHS = \
	plots/phase-transition.pdf \
	 $(foreach ps, 10 20 30, \
		 plots/graph-non-induced-satisfiable-$(ps)-150.pdf \
		 plots/graph-non-induced-nodes-$(ps)-150.pdf \
		 plots/graph-lad-non-induced-nodes-$(ps)-150.pdf \
		 plots/graph-vf2-non-induced-nodes-$(ps)-150.pdf ) \
	 $(foreach ps, 10 14 15 16 20 30, \
		 plots/graph-induced-satisfiable-$(ps)-150.pdf \
		 plots/graph-induced-nodes-$(ps)-150.pdf \
		 plots/graph-lad-induced-nodes-$(ps)-150.pdf \
		 plots/graph-vf2-induced-nodes-$(ps)-150.pdf \
		 plots/graph-vf3-induced-nodes-$(ps)-150.pdf ) \
	 $(foreach ps, 10 14 15 16 20 30, \
		 plots/graph-induced-kappa-$(ps)-150.pdf \
		 plots/graph-induced-which-$(ps)-150.pdf ) \
	 $(foreach ps, 10 12 14 16 18 25, \
		 plots/graph-induced-satisfiable-$(ps)-75.pdf \
		 plots/graph-induced-nodes-$(ps)-75.pdf \
		 plots/graph-clasp-induced-nodes-$(ps)-75.pdf \
		 plots/graph-glucose-induced-nodes-$(ps)-75.pdf \
		 plots/graph-clique-induced-nodes-$(ps)-75.pdf \
		 plots/graph-gurobi-induced-nodes-$(ps)-75.pdf ) \
	 $(foreach ps, 10 20 30, \
		 plots/graph-non-induced-kr-satisfiable-$(ps)-150.pdf \
		 plots/graph-non-induced-kr-nodes-$(ps)-150.pdf \
		 plots/graph-lad-non-induced-kr-nodes-$(ps)-150.pdf \
		 plots/graph-vf2-non-induced-kr-nodes-$(ps)-150.pdf ) \
	$(foreach l, 2 3 5 10 20, \
		 plots/graph-non-induced-satisfiable-20-l$(l)-150.pdf \
		 plots/graph-non-induced-nodes-20-l$(l)-150.pdf \
		 plots/graph-lad-non-induced-nodes-20-l$(l)-150.pdf \
		 plots/graph-vf2-non-induced-nodes-20-l$(l)-150.pdf ) \
	plots/skewed.pdf \
	plots/biiiig-data-aids.pdf \
	plots/biiiig-data-pcms.pdf \
	plots/biiiig-data-pdbs.pdf \
	plots/biiiig-data-ppigo.pdf \

TABLES =

graphs : $(GRAPHS)

tables : $(TABLES)

plots/%.pdf : plots/%.gnuplot
	cd plots && \
	    gnuplot $*.gnuplot && \
	    sed -i -e '19s/^\(\\path.*\)/\% haxxed out \1/' $*.tex \
	    && latexmk -pdf $*

define hardsip_GRAPH_template =

plots/graph-$(1)-satisfiable-$(2)-$(3).pdf : plots/graph-satisfiable-template.gnuplot
	cd plots && \
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "satlines=$(4)" -e "divide=$(5)" `basename $$<` && \
	latexmk -pdf graph-$(1)-satisfiable-$(2)-$(3)

plots/graph-$(1)-nodes-$(2)-$(3).pdf : plots/graph-nodes-template.gnuplot
	cd plots && \
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "divide=$(5)" `basename $$<` && \
	latexmk -pdf graph-$(1)-nodes-$(2)-$(3)

plots/graph-$(1)-kappa-$(2)-$(3).pdf : plots/graph-kappa-template.gnuplot
	cd plots && \
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "divide=$(5)" `basename $$<` && \
	latexmk -pdf graph-$(1)-kappa-$(2)-$(3)

plots/graph-$(1)-which-$(2)-$(3).pdf : plots/graph-which-template.gnuplot
	cd plots && \
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "divide=$(5)" `basename $$<` && \
	latexmk -pdf graph-$(1)-which-$(2)-$(3)

endef

$(foreach ps, 10 20 30, \
    $(foreach f, non-induced lad-non-induced vf2-non-induced, \
    $(eval $(call hardsip_GRAPH_template,$(f),$(ps),150,1,100))))

$(foreach ps, 10 14 15 16 20 30, \
    $(foreach f, induced lad-induced vf2-induced, \
    $(eval $(call hardsip_GRAPH_template,$(f),$(ps),150,2,100))))

$(foreach ps, 10 14 15 16 20 30, \
    $(foreach f, vf3-induced, \
    $(eval $(call hardsip_GRAPH_template,$(f),$(ps),150,2,100))))

$(foreach ps, 10 12 14 16 18 25, \
    $(foreach f, induced clasp-induced glucose-induced clique-induced gurobi-induced, \
    $(eval $(call hardsip_GRAPH_template,$(f),$(ps),75,0,50))))

define hardsip_KRGRAPH_template =
plots/graph-$(1)-kr-satisfiable-$(2)-$(3).pdf : plots/graph-krsatisfiable-template.gnuplot
	cd plots && \
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "divide=$(4)" `basename $$<` && \
	latexmk -pdf graph-$(1)-kr-satisfiable-$(2)-$(3)

plots/graph-$(1)-kr-nodes-$(2)-$(3).pdf : plots/graph-krnodes-template.gnuplot
	cd plots && \
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "divide=$(4)" `basename $$<` && \
	latexmk -pdf graph-$(1)-kr-nodes-$(2)-$(3)
endef

$(foreach ps, 10 20 30, \
    $(foreach f, non-induced lad-non-induced vf2-non-induced, \
    $(eval $(call hardsip_KRGRAPH_template,$(f),$(ps),150,149))))

define hardsip_LGRAPH_template =
plots/graph-$(1)-satisfiable-$(2)-l$(3)-$(4).pdf : plots/graph-lsatisfiable-template.gnuplot
	cd plots && \
	gnuplot -e "ps=$(2)" -e "ts=$(4)" -e "l=$(3)" -e "format='$(1)'" -e "satlines=$(5)" -e "divide=$(6)" `basename $$<` && \
	latexmk -pdf graph-$(1)-satisfiable-$(2)-l$(3)-$(4)

plots/graph-$(1)-nodes-$(2)-l$(3)-$(4).pdf : plots/graph-lnodes-template.gnuplot
	cd plots && \
	gnuplot -e "ps=$(2)" -e "ts=$(4)" -e "l=$(3)" -e "format='$(1)'" -e "plotsize='$(5)'" -e "divide=$(6)" `basename $$<` && \
	latexmk -pdf graph-$(1)-nodes-$(2)-l$(3)-$(4)
endef

$(foreach l, 2 3 5 10 20, \
    $(foreach f, non-induced lad-non-induced vf2-non-induced, \
    $(eval $(call hardsip_LGRAPH_template,$(f),20,$(l),150,2,100))))

