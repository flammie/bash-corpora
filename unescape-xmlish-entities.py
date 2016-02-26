#!/usr/bin/env python3

from sys import argv, stdin
from html import unescape

infiles = []
if len(argv) < 1:
    print("Usage:", argv[0])
    print("Convert XML and such entity references in stdin to stdout")
    exit(1)
for line in stdin:
    print(unescape(line.rstrip('\n')))
