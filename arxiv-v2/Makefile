all:
	latexmk -pdf paper

tarball: __includes.tex abstract.tex appendix-combined.tex appendix-empirical.tex conclusions.tex empirical.tex intro.tex lowerbound.tex paper.tex rates.tex setting.tex upperbound.tex paper.bbl
	tar cvf paper.tar __includes.tex abstract.tex appendix-combined.tex appendix-empirical.tex conclusions.tex empirical.tex intro.tex lowerbound.tex paper.tex rates.tex setting.tex upperbound.tex paper.bbl

clean:
	latexmk -C paper
	rm -f *.thm
