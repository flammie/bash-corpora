#!/bin/bash

if test $# -ne 2 ; then
    echo Usage: $0 LINES FILE
    exit 1
fi

maxline=$(wc -l < $2)
for i in $(seq 1 $1) ; do
    head -n $(($RANDOM * $maxline / 32767)) < $2 | tail -n 1
done
