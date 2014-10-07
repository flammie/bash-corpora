#!/bin/bash
# This script is meant for unpacking and cleaning up mediawiki dumps to be
# usable as linguistic corpus.

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] PROJECT [VERSION [DATASET]]
    Unpack and clean up fetched wikipedia dump. Removes XML formatting and most
    of the wiki formatting, including hopefully most of macros. Recodes UTF-8
    for illegal byte sequences.

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
    unpack-wikimedia.bash (Flammie's useful corpora kludges) 0.1
    Copyright © 2013 Flammie Pirinen
    Licence GPLv3+: GPL version 3 or newer <http://gnu.org/licenses/gpl.html>.
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    Written by Flammie Pirinen.
EOVERS
}

HTML_ENTITIES=html-entity-names.sed
if ! test -f html-entity-names.sed ; then
    if test -f "$(dirname $0)/html-entity-names.sed" ; then
        HTML_ENTITIES="$(dirname $0)/html-entity-names.sed"
    else
        echo "Cannot find html-entities.sed"
        exit 1
    fi
fi
XML_ENTITIES=xml-entity-codes.sed
if ! test -f xml-entity-codes.sed ; then
    if test -f "$(dirname $0)/xml-entity-codes.sed" ; then
        XML_ENTITIES="$(dirname $0)/xml-entity-codes.sed"
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
            if test -z $PROJECT ; then
                PROJECT=$1;
            elif test -z $DATE ; then
                DATE=$1;
            elif test -z $DATA ; then
                DATA=$1
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

DUMPFILE=$PROJECT-$DATE-$DATA.xml.bz2
if test -f $DUMPFILE ; then
    bzcat $DUMPFILE |\
        awk '/<text/,/<\/text/ {print}' |\
        iconv -c -f utf8 -t utf8//IGNORE |\
        awk "/(^[[:alnum:]=']|^ *$)/ {print;}" |\
        sed -e 's/#REDIRECT.*//g' \
        -e 's/#redirect.*//g' \
        -e 's/\[\[...\?:[^]]*\]\]//g' \
        -e 's/<[^>]*>//g' \
        -e 's/\&lt;.*\&gt;//' \
        -e 's/\[\[[^]|]*|//g' \
        -e 's/\]\]//g' \
        -e 's/{{[^}]*}}//g' \
        -e "s/'''*//g" \
        -e 's/^{\?|.*//g' \
        -e 's/^\[\[[a-z]*:.*//g' \
        -e 's/[a-z]*=[a-z0-9]*//g' \
        -e 's/^[!:-].*//g' \
        -e 's/Category://g' \
        -e 's/\&amp;/&/g' |\
        sed -f ${HTML_ENTITIES} |\
        sed -f ${XML_ENTITIES} |\
        tr -s "[=|]{}<>*" " "
else
    echo "Fetched data not foudnd in $DUMPFILE"
    exit 2
fi
