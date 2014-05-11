#!/bin/bash
# This script is meant for fetching selection of books from gutenberg data using
# methods they suggest in their wiki

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] [LANG1 LANG2]
    Fetch europarl data.

    LANG1, LANG2 is ISO 639 code, such as en, de, fi etc.
    if LANGs aren't supplied whole source is downloaded
EOUSAGE
}

version() {
    cat<<-EOVERS
    fetch-europarl.bash (Flammie's useful corpora kludges) 0.1
    Copyright © 2013 Flammie Pirinen
    Licence GPLv3+: GPL version 3 or newer <http://gnu.org/licenses/gpl.html>.
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    Written by Flammie Pirinen.
EOVERS
}

while test $# -gt 0 ; do
    case $1 in
        -h|--help)
            usage; exit 0;;
        -V|--version)
            version; exit 0;;
        *)
            if test -z $L1 ; then
                L1="$1"
            elif test -z $L2 ; then
                L2="$1"
            else
                echo "too many parameters $L1 $L2 ... $@"
                exit 1
            fi
    esac
    shift
done
if test -z $L2 ; then
    L2=en
fi
if type -p wget ; then
    URL=http://www.statmt.org/europarl/v7/$L1-$L2.tgz
    if test -z $L1 ; then
        URL=http://www.statmt.org/europarl/v7/europarl.tgz
    fi
    if ! wget "$URL" ; then
        echo "Fetching language $L1-$L2 failed, see above for further info"
        exit 1
    fi
fi
