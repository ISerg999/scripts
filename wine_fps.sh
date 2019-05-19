#!/bin/bash

tput clear
read -r GP
clear
P=${GP%/*.*}
echo "bash -c \"cd $P/' && env WINEPREFIX="$HOME/.wine" WINEDEBUG=fps wine $GP 2>&1 | tee /dev/stderr | grep --line-buffered "^trace:fps:" | osd_cat -o 30 -c green -s 1 -l2\"" > fps.txt
. fps.txt
rm fps.txt
