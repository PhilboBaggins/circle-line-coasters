.PHONY: all clean

all:
	make -C LinesFromPointCoasters all
	make -C RandoLineCoasters all
	make -C CoasterHolder all

clean:
	make -C LinesFromPointCoasters clean
	make -C RandoLineCoasters clean
	make -C CoasterHolder clean
