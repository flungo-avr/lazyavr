all: hw.h

%.h: %.sh c.sh %.*
	./$<

.PHONY: git-pull

git-pull:
	git pull
