#!/bin/bash
# Unpack gutenberg ebook collection that was fetched with official robotting
# script

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] [MIRRORDIR [FORMAT]]
    Unpack and clean fetched gutenberg files into one corpus. Removes licence
    info and other metadata, and converts encoding to UTF-8 as possible.

    MIRRORDIR is the directory where the ebooks have been fetched, if omitted,
    current directory is used.
    FORMAT is format of books that have been fetched, such as txt, html etc.
    If omitted, txt is assumed.
    FENC is character encoding format of ebooks, as understood by iconv. If
    omitted, latin1 will be attempted.
EOUSAGE
}

version() {
    cat<<-EOVERS
    unpack-gutenbergs.bash (Flammie's useful corpora kludges) 0.1
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
            if test -z $GUTENBERGS ; then
                GUTENBERGS=$1;
            elif test -z $FORMAT ; then
                FORMAT=$1;
            fi;;
    esac
    shift
done

if test -z $GUTENBERGS ; then
    GUTENBERGS="./"
fi
if test -z $FORMAT ; then
    FORMAT="txt"
fi

# gutenbergs are a bit of a mess when robot downloaded
find $GUTENBERGS -name '*.zip' > .gutenberglist.tmp
for f in $(< .gutenberglist.tmp) ; do
    echo ${f}... 1>&2
    FENC=$(unzip -c $f | fgrep -m 1 "Character set encoding" | sed -e 's/^.*: //' | dos2unix)
    if test -z $FENC ; then
        echo "missing Character set encoding, skipping" 1>&2
        continue
    elif test $FENC = "ASCII" ; then
        echo "$FENC, skipping" 1>&2
        continue
    fi
    unzip -c $f |\
        iconv -f $FENC -t utf8//TRANSLIT//IGNORE |\
        dos2unix |\
        awk '/START OF .* PROJECT GUTENBERG EBOOK/,/END OF .* PROJECT GUTENBERG EBOOK/ {print;}' |\
        sed -e 's/START OF.*//' -e 's/END OF.*//'
done

