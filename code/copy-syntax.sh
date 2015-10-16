#!/bin/bash

FONT_SIZE=40
FONT_FAMILY=Hack
STYLE=molokai
#SYNTAX=ruby
OUTPUT=rtf
FILTER=false
START=1

while getopts ":s:S:K:L:f" OPT; do
  case $OPT in
    s)
      STYLE="$OPTARG"
      shift 2
      ;;
    #S)
    #  SYNTAX="$OPTARG"
    #  shift 2
    #  ;;
    K)
      FONT_SIZE="$OPTARG"
      shift 2
      ;;
    L)
      START="$OPTARG"
      shift 2
      ;;
    f)
      FILTER=true
      shift
      ;;
    \?)
      exit 1
      ;;
  esac
done

FILENAME="$1"

if [[ -z "$FILENAME" ]]; then
  >&2 echo 'Please supply filename'
  exit 1
fi

EXT="${FILENAME##*.}"

SYNTAX=ruby
case $EXT in
  scss)
    SYNTAX=scss
    ;;
  css)
    SYNTAX=css
    ;;
  sh)
    SYNTAX=sh
    ;;
esac


#if [[ "$EXT" == "scss" ]]; then
#  SYNTAX=scss
#elif [[ "$EXT" == "css" ]]; then
#  SYNTAX=css
#else
#  SYNTAX=ruby
#fi

#case "$EXT" in
#  scss)
#    SYNTAX=scss
#    ;;
#  rb)
#    SYNTAX=ruby
#    ;;
#esac

if [[ "$FILTER" == true ]]; then
  CONTENTS=$(cat "$FILENAME" | grep -Ev "^(?:import|export)")
else
  CONTENTS=$(cat "$FILENAME")
fi

echo "$CONTENTS" | tail -n+"$START"| highlight -s "$STYLE" -O "$OUTPUT" -S "$SYNTAX" -K "$FONT_SIZE" -k "$FONT_FAMILY" | tr -d '\n' | pbcopy
