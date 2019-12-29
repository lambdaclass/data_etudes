BUILD_DIR = build
NOTEBOOKS_DIR = notebooks

MARKDOWN = ./dont_bet_on_an_ev/dont_bet_on_an_ev.md
PANDOC_TEMPLATE =  ./dont_bet_on_an_ev/template.tmpl
PANDOC_HTML_OUTPUT = dont_bet_on_an_ev.html

.PHONY: default central_limit_theorem_misuse dont_bet_on_an_ev

default: index central_limit_theorem_misuse dont_bet_on_an_ev

dev: default
	python -m http.server

central_limit_theorem_misuse:
	mkdir -p build/central_limit_theorem_misuse/img
	mkdir -p build/central_limit_theorem_misuse/js
	mkdir -p build/central_limit_theorem_misuse/css
	-cp -R ./central_limit_theorem_misuse/img/* $(BUILD_DIR)/central_limit_theorem_misuse/img/
	-cp -R ./central_limit_theorem_misuse/js/* $(BUILD_DIR)/central_limit_theorem_misuse/js/
	-cp -R ./central_limit_theorem_misuse/css/* $(BUILD_DIR)/central_limit_theorem_misuse/css/
	pandoc ./central_limit_theorem_misuse/README.md --template ./central_limit_theorem_misuse/template.tmpl -t html5 --mathjax -o $(BUILD_DIR)/central_limit_theorem_misuse/index.html --metadata title="The Central Limit Theorem and its misuse"

dont_bet_on_an_ev:
	mkdir -p build/img
	mkdir -p build/js
	mkdir -p build/css
	cp -R ./dont_bet_on_an_ev/img/* $(BUILD_DIR)/img/
	cp -R ./dont_bet_on_an_ev/js/* $(BUILD_DIR)/js/
	cp -R ./dont_bet_on_an_ev/css/* $(BUILD_DIR)/css/
	pandoc $(MARKDOWN) --template $(PANDOC_TEMPLATE) -t html5 --mathjax -o $(BUILD_DIR)/$(PANDOC_HTML_OUTPUT) --metadata title="Don't bet on an expected value"

index:
	mkdir -p $(BUILD_DIR)
	pandoc README.md --template ./template.tmpl -t html5 -o $(BUILD_DIR)/index.html --metadata title="LambdaClass Data Études"
