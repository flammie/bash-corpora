#!/bin/bash
# This script is meant for fetching selection of books from gutenberg data using
# methods they suggest in their wiki

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] [LANGS [FORMATS]]
    Fetch gutenberg ebooks using officially sanctioned methods.

    LANG are ISO 639 codes, such as en, de, fi etc. If omitted, all languages
    will be fetched.
    FORMAT is format of books to fetch, such as txt, html etc. If omitted, all
    formats will be fetched.
EOUSAGE
}

version() {
    cat<<-EOVERS
    fetch-gutenberg.bash (Flammie's useful corpora kludges) 0.1
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
            elif test -z $FORMAT ; then
                FORMAT=$1;
            fi;;
    esac
    shift
done


# Gutenberg fetch from 
# <http://www.gutenberg.org/wiki/Gutenberg:Information_About_Robot_Access_to_our_Pages>
if test -n $LL -a -n $FORMAT ; then
    URL="http://www.gutenberg.org/robot/harvest?filetypes[]=$FORMAT&langs[]=$LL"
elif test -n $LL ; then
    URL="http://www.gutenberg.org/robot/harvest?&langs[]=$LL"
else
    URL="http://www.gutenberg.org/robot/harvest"
fi
if type -p wget ; then
    if ! wget -w 2 -m -H "$URL" ; then
        echo "Fetch failed, see above for more info"
    fi
fi

