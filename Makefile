# The MIT License (MIT)
#
# Copyright (c) 2015 Fabrizio Lungo <fab@lungo.co.uk>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# C Generation helper script
CHELP_SCRIPT    = scripts/c.sh
# HW Mapping Script
HWMAP_SCRIPT    = scripts/hwmap.sh

# For all .map files in platforms, a header will be generated
MAPS            = $(wildcard platforms/*.map)
MAPPING_HEADERS = $(addsuffix .h, $(MAPS))

# Generate all components
all: $(MAPPING_HEADERS)

# HW Mapping Script depends on C Generation helper script
$(HWMAP_SCRIPT): | $(CHELP_SCRIPT)

# Create a .map.h from the .map
platforms/%.map.h: platforms/%.map | $(HWMAP_SCRIPT)
	$(HWMAP_SCRIPT) "$<"

.PHONY: clean

clean:
	rm -rf $(MAPPING_HEADERS)

.PHONY: git-pull

git-pull:
	git pull
