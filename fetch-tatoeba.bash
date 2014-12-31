#!/bin/bash
# This script is meant for fetching selection of books from gutenberg data using
# methods they suggest in their wiki

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...]
    Fetch tatoeba data.

    LANG is ISO 639 code, such as en, de, fi etc.
    if LANGs aren't supplied whole source is downloaded
EOUSAGE
}

version() {
    cat<<-EOVERS
    fetch-tatoeba.bash (Flammie's useful corpora kludges) 0.1
    Copyright © 2014 Flammie Pirinen
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
            echo "too many parameters ... $@"
            exit 1;;
    esac
    shift
done
if type -p wget ; then
    URL=http://downloads.tatoeba.org/exports/sentences.tar.bz2
    if ! wget "$URL" ; then
        echo "Fetching language tatoeba failed, see above for further info"
        exit 1
    fi
fi
