#!/bin/bash
# simple script to install all scripts to given path

if test $# -gt 0 ; then
    DEST=$1
else
    DEST=$HOME/bin/
fi
SCRIPTS="fetch-europarl.bash fetch-gutenberg.bash fetch-wikimedia.bash \
    fetch-jrc-acquis.bash \
    unpack-europarl.bash unpack-gutenbergs.bash unpack-wikimedia.bash\
    unpack-jrc-acquis.bash"
DATA="html-entity-names.sed xml-entity-codes.sed \
    common-sgml-entities.sed"
if ! test -d $DEST ; then
    install -d  $DEST
fi
install -m 755 $SCRIPTS $DEST
install -m 644 $DATA $DEST
