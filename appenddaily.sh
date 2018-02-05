#!/bin/sh

DATAFILE="$HOME/tmp/amat_hs.dat.gz"

LANG=C
export LANG

DAY=$(date -d yesterday +%a | tr A-Z a-z)
URL=http://wireless.fcc.gov/uls/data/daily/l_am_${DAY}.zip

TMP=$(mktemp)

wget -q -O $TMP $URL

unzip -p $TMP HS.dat | grep SYSGRT | gzip -c >> $DATAFILE

rm -f $TMP
