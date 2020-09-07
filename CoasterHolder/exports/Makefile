NAME := CoasterHolder

ALL_2D := \
	${NAME}.dxf \
	${NAME}.svg

ALL_3D := \
	${NAME}.stl \
	${NAME}.png

.PHONY: all clean

all: ${ALL_2D} ${ALL_3D}

${ALL_2D}: ${NAME}2D.scad ../${NAME}.scad
	openscad -o $@ $<

${ALL_3D}: ${NAME}3D.scad ../${NAME}.scad
	openscad -o $@ $<

clean:
	rm -f ${ALL_2D} ${ALL_3D}
