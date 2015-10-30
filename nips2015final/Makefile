all:
	latexmk -pdf paper

split: paper-short.pdf paper-appendix.pdf

paper-short.pdf: paper.pdf
	gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dFirstPage=1 -dLastPage=9 -sOutputFile=paper-short.pdf paper.pdf

paper-appendix.pdf: paper.pdf
	gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dFirstPage=10 -sOutputFile=paper-appendix.pdf paper.pdf

clean:
	latexmk -C paper
	rm -f *.bbl *.thm
