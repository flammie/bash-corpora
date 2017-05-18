#!/bin/bash

if test $# -ne 2 ; then
    echo "Usage: $0 REF1 REF2"
    echo "manually compare two files line by line for betterness"
    exit 1
fi
LEFT=$1
RIGHT=$2
if test -f $LEFT.$RIGHT ; then
    rm -v -i $LEFT.$RIGHT
fi
if test -f $LEFT.$RIGHT.results ; then
    rm -v -i $LEFT.$RIGHT.results
fi

paste $LEFT $RIGHT > $LEFT.$RIGHT

while read l ; do
    first=$(echo "$l" | cut -f 1)
    second=$(echo "$l" | cut -f 2)
    echo which one is the best:
    select a in "${first}" "${second}" dunno quit ; do
        if test "x${a}" = "x${first}" ; then
            echo "$LEFT" >> $LEFT.$RIGHT.results
            break
        elif test "x${a}" = "x${second}" ; then
            echo "$RIGHT" >> $LEFT.$RIGHT.results
            break
        elif test x${a} = xdunno ; then
            echo NEITHER >> $LEFT.$RIGHT.results
            break
        elif test x${a} = xquit ; then
            break 2
        else
            echo select 1 2 3 4
        fi
    done <&4
done 4<&0 < $LEFT.$RIGHT

sort $LEFT.$RIGHT.results | uniq -c | sort -nr

echo "can remove temporaries now by"
echo "rm -v $LEFT.$RIGHT.results $LEFT.$RIGHT"

