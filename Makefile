all: hw.h

%.h: %.sh
	./$<
