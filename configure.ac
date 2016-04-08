## Process this file with autoconf to produce configure scripts

## Copyright (c) 2014 Flammie

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.


AC_INIT([flammie-bash-corpora], [20160105], [https://github.com/flammie/bash-corpora/issues], [flammie-bash-corpora])
AM_INIT_AUTOMAKE([-Wall -Werror -Wno-portability foreign])

# arguments
AC_ARG_WITH([wikiextractor],
            [AS_HELP_STRING([--with-wikiextractor],
                            [path to WikiExtractor.py @<:@default=/usr/local@:>@])],
            [with_wikiextractor=$withval],
            [with_wikiextractor=.])


# Programs
AM_PATH_PYTHON([3.4],, [:])
AS_IF([test x$PYTHON = x:], [AC_MSG_ERROR([python-3.4 is required for html.unescape])])
AC_PATH_PROGS([WIKIEXTRACTOR], [wikiextractor WikiExtractor.py], [false])
AC_PATH_PROG([WIKIEXTRACTORPY], [WikiExtractor.py], [false], 
             [$PATH$PATH_SEPARATOR$with_wikiextractor])
AC_PATH_PROG([WGET], [wget], [false])
AC_PATH_PROGS([TAR], [gnutar gtar tar], [false])
AC_PATH_PROG([ICONV], [iconv], [false])
AC_PATH_PROG([UCONV], [uconv], [false])
AC_PATH_PROGS([DOS2UNIX], [dos2unix fromdos], [false])

AS_IF([test x$DOS2UNIX = xfalse], [AC_MSG_ERROR([dos2unix or fromdos is required])])


# some oses are broken
AC_PATH_PROGS_FEATURE_CHECK([SED], [gnused gsed sed],
              [[m4out=`echo aaa | $ac_path_SED 's/a/\n/g' | wc -l`
                test "x$m4out" = x4\
                && ac_cv_path_SED=$ac_path_SED ac_path_SED_found=:]],
              [AC_MSG_ERROR([could not find sed that supports new line])])
AC_SUBST([SED], [$ac_cv_path_SED])



AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([unpack-wikimedia.bash],
                [chmod +x unpack-wikimedia.bash])
AC_OUTPUT

cat <<EOF
-- Making $PACKAGE_STRING

To install say make install
EOF
