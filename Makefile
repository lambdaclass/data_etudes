HTML_DIR = html
NOTEBOOKS_DIR = notebooks

TEX = ./dont_bet_on_an_ev/dont_bet_on_an_ev.tex
PANDOC_TEMPLATE =  ./dont_bet_on_an_ev/template.tmpl
PANDOC_HTML_OUTPUT = dont_bet_on_an_ev.html

.PHONY: html

html:
	-mkdir -p $(HTML_DIR)
	cp -R $(NOTEBOOKS_DIR)/* $(HTML_DIR)
	jupyter --version
	-jupyter nbconvert $(HTML_DIR)/*.ipynb
	-rm $(HTML_DIR)/*.ipynb

dont_bet_on_an_ev_to_html:
	pandoc $(TEX) --template $(PANDOC_TEMPLATE) -t html5 -o $(HTML_DIR)/$(PANDOC_HTML_OUTPUT)
