#!/bin/bash
# This script is meant for fetching selection of books from gutenberg data using
# methods they suggest in their wiki

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] LANG...
    Fetch JRC Acquis 3.0  europarl data.

    LANG is ISO 639 code, such as en, de, fi etc.
EOUSAGE
}

version() {
    cat<<-EOVERS
    fetch-jrc-acquis.bash (Flammie's useful corpora kludges) 0.1
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
            LL="$1 $LL"
    esac
    shift
done

if type -p wget ; then
    for l in $LL ; do
        URL=http://optima.jrc.it/Acquis/JRC-Acquis.3.0/corpus/jrc-$l.tgz
        if ! wget "$URL" ; then
            FAILS="$l $FAILS"
        fi
        sleep 2
    done
fi
if test -n $FAILS ; then
    echo "Fetching languages: $FAILS failed, see above for further info"
fi
