bash-corpora
============
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
