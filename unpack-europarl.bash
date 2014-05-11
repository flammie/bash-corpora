#!/bin/bash
# Unpack gutenberg ebook collection that was fetched with official robotting
# script

usage() {
    cat<<-EOUSAGE
    Usage: $0 [OPTIONS...] LANG [LANG1 LANG2]
    Unpack and clean fetched europarl files into one corpus. Removes metadata
    and XML.

    LANG is the ISO 639 code or filename for language to unpack and
    LANG1,2 define the language pair that has been fetched
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
            elif test -z $L1 ; then
                L1=$1
            elif test -z $2 ; then
                L2=$2
            else
                echo Too many parameters $LL $L1 $L2 ... $@
                exit 1
            fi;;
    esac
    shift
done

if test -z $LL ; then
    usage
    exit 1
fi
if test -z $L2 ; then
    L2=en
fi
if test -f $L1-$L2.tgz ; then
    tar zxvf "$L1-$L2.tgz" europarl-v7.$L1-$L2.$LL
elif test -f europarl.tgz ; then
    tar zxvf europarl.tgz europarl-v7.$LL
fi

cat europarl-v7.$L1-$L2.$LL
