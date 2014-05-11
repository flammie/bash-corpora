#!/bin/bash
# Try to extract relevant text fields from HTML [12345] that is not awfully
# strange, script driven or anything.

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] [FILES...]
    Try to clean HTML file for plain text processing.

    If FILES is omitted, standard input will be used.
EOUSAGE
}

version() {
    cat<<-EOVERS
    clean-html.bash (Flammie's useful corpus kludges) 0.1
    Copyright © 2013 Flammie Pirinen
    Licence GPLv3+: GPL version 3 or newer <http://gnu.org/licenses/gpl.html>.
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    Written by Flammie Pirinen.
EOVERS
}

HTML_ENTITIES=html-entity-names.sed
if ! test -f html-entity-names.sed ; then
    if test -f "$(dirname $0)/html-entities.sed" ; then
        HTML_ENTITIES="$(dirname $0)/html-entities.sed"
    else
        echo "Cannot find html-entities.sed"
        exit 1
    fi
fi

while test $# -gt 0 ; do
    case $1 in
        -h|--help)
            usage; exit 0;;
        -V|--version)
            version; exit 0;;
        *)
            FILES="$FILES $1";;
    esac
    shift
done

cat $FILES |\
    awk 'BEGIN {PRINT=0;} /<body/ {PRINT=1} /<(script|style)/ {PRINT-=1;} /<\/(script|style)/ {PRINT+=1;} /.*/ {if (PRINT==1) {print;}}' |\
    sed -e 's/<[^>]*>//g' |\
    sed -f ${HTML_ENTITIES}
