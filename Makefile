all: hw.h

%.h: %.sh
	./$<

.PHONY: git-pull

git-pull:
	git pull
