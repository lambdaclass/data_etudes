TEX = dont_bet_on_an_ev.tex
PANDOC_TEMPLATE =  template.tmpl
PANDOC_HTML_OUTPUT = dont_bet_on_an_ev.html

default: compile

compile:

compile_pdf:
	tectonic $(TEX)

compile_html:
	pandoc $(TEX) --template $(PANDOC_TEMPLATE) -t html5 -o $(PANDOC_HTML_OUTPUT)

dev: compile_html
	python -m http.server
