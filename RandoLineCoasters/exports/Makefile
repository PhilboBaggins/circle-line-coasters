.PHONY: all clean

SRC_FILES := $(wildcard *.scad)
DXF_FILES := $(patsubst %.scad,%.dxf,$(SRC_FILES))
SVG_FILES := $(patsubst %.scad,%.svg,$(SRC_FILES))
PNG_FILES := $(patsubst %.scad,%.png,$(SRC_FILES))

ALL := $(DXF_FILES) $(SVG_FILES) $(PNG_FILES)

all: $(ALL)

%.dxf: %.scad ../RandoLineCoasters.scad
	openscad -o $@ $<

%.svg: %.scad ../RandoLineCoasters.scad
	openscad -o $@ $<

%.png: %.svg
	magick convert $< $@

clean:
	rm -f $(ALL)
