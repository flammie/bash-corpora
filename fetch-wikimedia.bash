#!/bin/bash
# This script is meant for fetching wikimedia-maintained database dumps

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] PROJECT [VERSION [DATASET [MIRROR]]]
    Fetch mediawiki project's database dump.

    PROJECT names are of form LLname, where LL is usually a ISO 639 
    language code, and name is mediawiki project name, such as 
    wiki, wiktionary, wikibooks, etc. For full listing see 
      <http://dumps.wikimedia.org/backup-index.html>
    VERSION is date in YYYYMMDD format, if omitted, keyword latest
    is used."
    DATASET is the name of the dump, such pages-articles, 
    pages-meta-history or abstract. If omitted, pages-articles is used.
EOUSAGE
}

version() {
    cat<<-EOVERS
    fetch-wikimedia.bash (Flammie's useful corpora kludges) 0.1
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
            if test -z $PROJECT ; then
                PROJECT=$1;
            elif test -z $DATE ; then
                DATE=$1;
            elif test -z $DATA ; then
                DATA=$1
            elif test -z $MIRROR ; then
                MIRROR=$1
            fi;;
    esac
    shift
done

if test -z $PROJECT ; then
    usage
    exit 1
fi
if test -z $DATE; then
    DATE=latest
fi
if test -z $DATA ; then
    DATA=pages-articles
fi
if test -z $MIRROR ; then
    MIRROR=dumps.wikimedia.org
fi
PROTO=http
URI=$PROTO://$MIRROR/$PROJECT/$DATE/$PROJECT-$DATE-$DATA.xml.bz2
# Check availability if possible
if type -p HEAD ; then
    if HEAD $URI ; then
        URI=$URI
    elif HEAD ${URI%.bz2}.7z ; then
        URI=${URI%.bz2}.7z
    elif HEAD ${URI%.bz2}.gz ; then
        URI=${URI%.bz2}.gz
    elif HEAD https:${URI#http:} ; then
        URI=https:${URI#http:}
    else
        echo "Failed to find good download address, try different MIRROR?"
        usage
        exit 2
    fi
else
    echo "Warning: current pre-download checks use lwp-request HEAD to test"
    echo "the connection to address and HEAD was not found; skipping check"
fi

# Wikipedia fetch
if type -p wget ; then
    if ! wget $URI ; then
        echo "Fetch failed. See above for additional info"
        exit 1
    fi
fi

