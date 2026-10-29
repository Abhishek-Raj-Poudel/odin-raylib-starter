# Odin + Raylib starter makefile

ODIN := odin
OUT := game
FLAGS := -collection:.. 

.PHONY: build run clean debug

build:
	$(ODIN) build . $(FLAGS) -out:$(OUT)

run: build
	./$(OUT)

debug:
	$(ODIN) build . $(FLAGS) -debug -out:$(OUT)_debug
	./$(OUT)_debug

clean:
	rm -f $(OUT) $(OUT)_debug
	rm -f *.pdb *.ilk

web:
	$(ODIN) build . $(FLAGS) -target:js_wasm32 -out:game.js
