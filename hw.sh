#!/bin/bash

. c.sh

FILE=hw.h
MAP=hw.map

init $FILE

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

map_hw > hw.h
