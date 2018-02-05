#!/bin/sh
DISTRICT=1
DATAFILE="$HOME/tmp/amat_hs.dat.gz"

LANG=C
export LANG

echo -n "D: "
gzip -dc $DATAFILE | \
	egrep "K[^HLP]${DISTRICT}[A-Z]{3}\\>.*SYSGRT" | \
	tail -1 | \
	awk -F '|' '{print $4}'

echo -n "B: "
gzip -dc $DATAFILE | \
	egrep "K[^HLP]${DISTRICT}[A-Z]{2}\\>.*SYSGRT" | \
	tail -1 | \
	awk -F '|' '{print $4}'

echo -n "A: "
gzip -dc $DATAFILE | \
	egrep "A[^HL-Z]${DISTRICT}[A-Z]{2}\\>.*SYSGRT" | \
	tail -1 | \
	awk -F '|' '{print $4}'

