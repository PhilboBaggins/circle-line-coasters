.PHONY: all clean

all: README.md
	make -C exports all
	make -C exports-selected all

README.md:
	ls exports-selected/*.png | awk '{ print "!["$$1"]("$$1")" }' > $@

clean:
	rm -f README.md
	make -C exports clean
	make -C exports-selected clean
