#!/bin/bash
# Unpack tatoeba ebook collection that was fetched with official robotting
# script

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] LANG
    Unpack and clean fetched opensubtitles.

    LANG is the ISO 639-3 code or filename for language that has been fetched.
EOUSAGE
}

version() {
    cat<<-EOVERS
    unpack-opensubtitles.bash (Flammie's useful corpora kludges) 0.1
    Copyright © 2016 Flammie Pirinen
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
            if test -z $LL ; then
                LL=$1;
            elif test -z $YEAR ; then
                YEAR=$2
            fi;;
    esac
    shift
done

if test -z $LL ; then
    usage
    exit 1
elif test -z $YEAR ; then
    YEAR=2018
fi

if test -f "OpenSubtitles$YEAR.raw.$LL.gz" ; then
    zcat "OpenSubtitles$YEAR.raw.$LL.gz"
fi
