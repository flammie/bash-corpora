#!/bin/bash
sed -e 's/[[:punct:]][[:space:][:punct:]]/ \0/g' \
    -e 's/[[:punct:]]\r\?$/ \0/' -e 's/^[[:punct:]]/\0 /' \
    -e 's/[[:space:]][[:punct:]]/\0 /g' -e 's/[[:space:]]/ /g' |\
    tr -s ' ' '\n'

