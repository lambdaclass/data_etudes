BUILD_DIR = build
NOTEBOOKS_DIR = notebooks

MARKDOWN = ./dont_bet_on_an_ev/dont_bet_on_an_ev.md
PANDOC_TEMPLATE =  ./dont_bet_on_an_ev/template.tmpl
PANDOC_HTML_OUTPUT = dont_bet_on_an_ev.html

.PHONY: default central_limit_theorem_misuses dont_bet_on_an_ev

default: index central_limit_theorem_misuses dont_bet_on_an_ev

central_limit_theorem_misuses:
	mkdir -p build/central_limit_theorem_misuses/img
	mkdir -p build/central_limit_theorem_misuses/js
	mkdir -p build/central_limit_theorem_misuses/css
	-cp -R ./central_limit_theorem_misuses/img/* $(BUILD_DIR)/central_limit_theorem_misuses/img/
	-cp -R ./central_limit_theorem_misuses/js/* $(BUILD_DIR)/central_limit_theorem_misuses/js/
	-cp -R ./central_limit_theorem_misuses/css/* $(BUILD_DIR)/central_limit_theorem_misuses/css/
	pandoc ./central_limit_theorem_misuses/readme.md --template ./central_limit_theorem_misuses/template.tmpl -t html5 --mathjax -o $(BUILD_DIR)/central_limit_theorem_misuses/index.html --metadata title="The Central Limit Theorem and its misuses"

dont_bet_on_an_ev:
	mkdir -p build/img
	mkdir -p build/js
	mkdir -p build/css
	cp -R ./dont_bet_on_an_ev/img/* $(BUILD_DIR)/img/
	cp -R ./dont_bet_on_an_ev/js/* $(BUILD_DIR)/js/
	cp -R ./dont_bet_on_an_ev/css/* $(BUILD_DIR)/css/
	pandoc $(MARKDOWN) --template $(PANDOC_TEMPLATE) -t html5 --mathjax -o $(BUILD_DIR)/$(PANDOC_HTML_OUTPUT) --metadata title="Don't bet on an expected value"

index:
	pandoc README.md --template ./template.tmpl -t html5 -o $(BUILD_DIR)/index.html
