# bash-corpora

This is free/libre open source collection of simple bash scripts to fetch,
preprocess and otherwise mangle your corpora from commandline. Unlike many
other tools out there, I made these to avoid the requirements of scripting
language interpreters, obscure tools or such. This makes many of the scripts
hacky, since, as we all know, only proper way to handle corpus formats based on
XML or such horrible gargantuan standards is to implement full-fledged
validating XML processor, a bunch of regexes will not cut it. Hence I have
nicknamed the repo *Flammie's useful corpus kludges*. These things should
give you some standard reference point on handling your corpora, no matter if
they really butcher it or not, but since reproducability is often more
important value, this might be useful just as well. 

This stuff is made on GNU system, so GNU versions of coreutils, sed, grep, awk
and whatnot, will be used by default. If you are stuck on a system that uses
crippled variants of these, such as Mac OS X, you are encouraged to switch to
GNU versions using software repositories like macports or homebrew. Even when
the BSD versions of tools seemingly work, slight differences in collation and
all will render different results in the end.

## Text container files

I’ve made some ad hoc "file formats" for my use here, it's not stable yet, but
usable. It solves for my personal use couple of problems that I commonly have
working with text files:

1. Metadata is increasingly important:
    * URL
    * Licence
    * Language
    * ... this is not a substitute to full corpus metadata, use all
      CMDI, DC and OLAC for that with OAI-PMHs and all. It's just something
      I found I actually need.
1. Plain texts are all not alike:
    * Preprocessing
    * Sentence per line vs. 80 characters per line
    * Other not-so-plain-text features

### Format

The format is super simple, it starts with magic shebang line:

```
#!/usr/bin/env corpus.bash
```

All lines afterwards starting with `#!` are metadata. There should not be other
non-empty lines after shebang, the text-content starts after first empty line.
There should not be lines starting with `#!` in text content. This means that
pretty standard way to turn Flammie's text container file into `text/plain` on
any reasonably unixy shell is: `egrep -v '^#!'` (and `tail -n +2` if you care 
about initial empty line. The suggested filename extension is `.text`, it may
be used elsewhere for other things but most plain text is `.txt` or without
extension, so I can glob this out easy enough.

### Discussion

I probably could’ve just used github flavored markdown or something with their
hyphen separated header, but really for most NLP tasks I like to process
plain texts on command line in the end, the main part of these bash scripts here
is to get rid of all the markups and -downs.

