.PHONY: all clean

all:
	make -C LinesFromPointCoasters all
	make -C RandoLineCoasters all

clean:
	make -C LinesFromPointCoasters clean
	make -C RandoLineCoasters clean
