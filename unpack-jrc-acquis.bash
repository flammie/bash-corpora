#!/bin/bash
# Unpack gutenberg ebook collection that was fetched with official robotting
# script

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] [LANG]
    Unpack and clean fetched europarl files into one corpus. Removes metadata
    and XML.

    LANG is the ISO 639 code or filename for language that has been fetched.
EOUSAGE
}

version() {
    cat<<-EOVERS
    unpack-europarl.bash (Flammie's useful corpora kludges) 0.1
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
            if test -z $LL ; then
                LL=$1;
            fi;;
    esac
    shift
done

if test -z $LL ; then
    usage
    exit 1
fi

if test -f "jrc-$LL.tgz" ; then
    tar zxf "jrc-$LL.tgz"
fi

find $LL -name '*.xml' -exec cat {} \; |\
    awk '/<text>/,/<\/text>/ {print;}' |\
    sed -e 's/<[^>]*>//g' -e 's/%quot%/’/g' -e 's/%gt%/>/g' -e 's/%auml%/ä/g' \
        -e 's/%ouml%/ö/g'
