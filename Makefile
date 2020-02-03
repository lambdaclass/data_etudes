BUILD_DIR = build

.PHONY: default central_limit_theorem_misuse dont_bet_on_an_ev

default: index central_limit_theorem_misuse dont_bet_on_an_ev

dev: default
	python -m http.server

central_limit_theorem_misuse:
	mkdir -p build/central_limit_theorem_misuse/img
	mkdir -p build/central_limit_theorem_misuse/css
	-cp -R ./central_limit_theorem_misuse/img/* $(BUILD_DIR)/central_limit_theorem_misuse/img/
	-cp -R ./central_limit_theorem_misuse/css/* $(BUILD_DIR)/central_limit_theorem_misuse/css/
	pandoc ./central_limit_theorem_misuse/README.md --template ./central_limit_theorem_misuse/template.tmpl -t html5 --mathjax -o $(BUILD_DIR)/central_limit_theorem_misuse/index.html --metadata title="The Central Limit Theorem and its misuse"

dont_bet_on_an_ev:
	mkdir -p $(BUILD_DIR)/dont_bet_on_an_ev/img/
	mkdir -p $(BUILD_DIR)/dont_bet_on_an_ev/css/
	mkdir -p $(BUILD_DIR)/dont_bet_on_an_ev/js/
	cp -R ./dont_bet_on_an_ev/img/* $(BUILD_DIR)/dont_bet_on_an_ev/img/
	cp -R ./dont_bet_on_an_ev/css/* $(BUILD_DIR)/dont_bet_on_an_ev/css/
	cp -R ./dont_bet_on_an_ev/js/* $(BUILD_DIR)/dont_bet_on_an_ev/js/
	pandoc ./dont_bet_on_an_ev/README.md --template ./dont_bet_on_an_ev/template.tmpl -t html5 --mathjax -o $(BUILD_DIR)/dont_bet_on_an_ev/index.html --metadata title="Don't bet on an Expected Value"

index:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/css/
	cp -R ./css/* $(BUILD_DIR)/css/
	pandoc README.md --template ./template.tmpl -t html5 -o $(BUILD_DIR)/index.html --metadata title="LambdaClass Data Études"
