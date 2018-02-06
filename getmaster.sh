#!/bin/sh

MASTERURL='http://wireless.fcc.gov/uls/data/complete/l_amat.zip'
DATAFILE="$HOME/tmp/amat_hs.dat.gz"
TMP=$(mktemp)

LANG=C
export LANG

wget --tries=3 --timeout=30 -q -O $TMP $MASTERURL

unzip -p $TMP HS.dat | grep SYSGRT | gzip -c > $DATAFILE

rm -f $TMP

