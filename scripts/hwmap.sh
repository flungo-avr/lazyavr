#!/bin/bash
#
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

SOURCE_DIR=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

. "${SOURCE_DIR}/c.sh"

MAP=$1
if [ ! -f $1 ]; then
  >&2 echo "$1 is not a file."
  exit 1;
fi

OUTPUT=$1.h

init $OUTPUT

map_line() {
  local ALIAS=$(echo $1 | cut -d'-' -f 1 | awk '{$1=$1}{ print }')
  local NAME=$(echo $1 | cut -d'>' -f 2 | awk '{$1=$1}{ print }')
  local PORT=${NAME:1:1}
  local PIN=${NAME:2:1}
  echo "#define ${ALIAS}_PORT PORT${PORT}"
  echo "#define ${ALIAS}_DDR  DDR${PORT}"
  echo "#define ${ALIAS}_PIN  P${PORT}${PIN}"
  echo "#define ${ALIAS}      ${ALIAS}_PORT, ${ALIAS}_DDR, ${ALIAS}_PIN"
}

map_hw() {

  cat $MAP | while read line; do
    case $line in
      "##"*)
        header ${line:2}
      ;;
      "# "*)
        comment ${line:2}
      ;;
      "#"*)
        echo $line
      ;;
      *"->"*)
        map_line "$line"
      ;;
      "")
        echo
      ;;
    esac
  done
}

map_hw > $OUTPUT
