MAIN_SRC_FILE := ../RandoLineCoasters.scad

SRC_FILES := $(wildcard *.scad)
DXF_FILES := $(patsubst %.scad,%.dxf,$(SRC_FILES))
SVG_FILES := $(patsubst %.scad,%.svg,$(SRC_FILES))
PNG_FILES := $(patsubst %.scad,%.png,$(SRC_FILES))

ALL := $(DXF_FILES) $(SVG_FILES) $(PNG_FILES) README.md

.PHONY: all clean

all: $(ALL)

README.md: $(PNG_FILES)
	ls *.png | awk '{ print "!["$$1"]("$$1")" }' > $@

%.dxf: %.scad $(MAIN_SRC_FILE)
	openscad -o $@ $<

%.svg: %.scad $(MAIN_SRC_FILE)
	openscad -o $@ $<

%.png: %.svg
	magick convert $< $@

clean:
	rm -f $(ALL)
