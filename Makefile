#all:
#	latexmk -pdf matrix-est

all:
	pdflatex matrix-est && bibtex bu1 && bibtex bu2 && pdflatex matrix-est && pdflatex matrix-est

split: paper-short.pdf paper-appendix.pdf

paper-short.pdf: matrix-est.pdf
	pdftk matrix-est.pdf cat 1-9 output paper-short.pdf

paper-appendix.pdf: matrix-est.pdf
	pdftk matrix-est.pdf cat 10-end output paper-appendix.pdf

clean:
	latexmk -C matrix-est
	rm -f *.bbl *.thm
