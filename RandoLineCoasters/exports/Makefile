.PHONY: all clean

SRC_FILES := $(wildcard *.scad)
SVG_FILES := $(patsubst %.scad,%.svg,$(SRC_FILES))

all: $(SVG_FILES)

%.svg: %.scad ../RandoLineCoasters.scad
	openscad -o $@ $<

clean:
	rm -f $(SVG_FILES)
