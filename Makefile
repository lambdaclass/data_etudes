BUILD_DIR = build
NOTEBOOKS_DIR = notebooks

TEX = ./dont_bet_on_an_ev/dont_bet_on_an_ev.md
PANDOC_TEMPLATE =  ./dont_bet_on_an_ev/template.tmpl
PANDOC_HTML_OUTPUT = dont_bet_on_an_ev.html

.PHONY: default build_dirs html

default: html dont_bet_on_an_ev

build_dirs:
	-mkdir -p $(BUILD_DIR)/img/
	-mkdir -p $(BUILD_DIR)/js/
	-mkdir -p $(BUILD_DIR)/css/

html: build_dirs
	cp -R $(NOTEBOOKS_DIR)/* $(BUILD_DIR)
	jupyter --version
	-jupyter nbconvert $(BUILD_DIR)/*.ipynb
	-rm $(BUILD_DIR)/*.ipynb

dont_bet_on_an_ev: build_dirs
	cp -R ./dont_bet_on_an_ev/img/* $(BUILD_DIR)/img/
	cp -R ./dont_bet_on_an_ev/js/* $(BUILD_DIR)/js/
	cp -R ./dont_bet_on_an_ev/css/* $(BUILD_DIR)/css/
	pandoc $(TEX) --template $(PANDOC_TEMPLATE) -t html5 -o $(BUILD_DIR)/$(PANDOC_HTML_OUTPUT)
