#!/bin/bash
# bash script to produce neat table of pairwise common lines between files

if test $# -lt 2 ; then
    echo "Usage: $0 FILE1 FILE2 [FILES...]"
    exit 1
fi
for f in $@ ; do
    sort $f $f.sorted
done
for f in $@ ; do
    echo -n $f 
    for g in $@ ; do
        comm -12 $f.sorted $g.sorted |\
            wc -l |\
            sed -e 's/^/\t/' |\
            tr -d '\n'
    done
    echo
done
for f in $@ ; do
    rm -v $f.sorted
done

