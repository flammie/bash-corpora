#!/bin/bash
# This script is meant for fetching selection of books from gutenberg data using
# methods they suggest in their wiki

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] LANG [LANG2 | tokenised | not-2016]
    Fetch open subtitles.

    LANG is ISO 639 code, such as en, de, fi etc.
    LANG2 will fetch aligned pair
    tokenised will fetch pre-tokenised data
    four digit series will attempt to download different year version
EOUSAGE
}

version() {
    cat<<-EOVERS
    fetch-opensubtitles.bash (Flammie's useful corpora kludges) 0.1
    Copyright © 2013 Flammie Pirinen
    Licence GPLv3+: GPL version 3 or newer <http://gnu.org/licenses/gpl.html>.
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    Written by Flammie Pirinen.
EOVERS
}

if test $# = 1 ; then
    LL=$1
elif test $# = 2 ; then
    LL=$1
    ARG=$2
else
    usage
    exit 1
fi

if type -p wget ; then
    URL=http://opus.lingfil.uu.se/download.php?f=OpenSubtitles2016/mono/OpenSubtitles2016.raw.$LL.gz
    if ! wget "$URL" -O OpenSubtitles2016.raw.$LL.gz ; then
        echo "Fetching $LL failed, see above for further info"
        exit
    fi
    sleep 2
fi
