#!/bin/sh

DISTRICT=$1
if [ ! "$DISTRICT" ]; then
	DISTRICT='1'
fi

if [ "$DISTRICT" -eq "10" ]; then
	DISTRICT='0'
fi

A="A[^HL-Z]${DISTRICT}[A-Z]{2}\\>"
B="K[^HLP]${DISTRICT}[A-Z]{2}\\>"
D="K[^HLP]${DISTRICT}[A-Z]{3}\\>"

# Alaska
if [ "$DISTRICT" -eq "11" ]; then
	A="[AKNW]L[0-9][A-Z]\\>"
	B="AL[0-9][A-Z]{2}\\>"
	C="[KNW]L[0-9][A-Z]{2}\\>"
	D="[KNW]L[0-9][A-Z]{3}\\>"
fi


DATAFILE="$HOME/tmp/amat_hs.dat.gz"

LANG=C
export LANG

echo -n "D: "
gzip -dc $DATAFILE					| \
	egrep "${D}.*SYSGRT"				| \
	sort -n -t "|" -k 2				| \
	tail -1						| \
	awk -F '|' '{print $4}'

if [ "$C" ]; then
	echo -n "C: "
	gzip -dc $DATAFILE					| \
		egrep "${C}.*SYSGRT"				| \
		sort -n -t "|" -k 2				| \
		tail -1						| \
		awk -F '|' '{print $4}'
fi

echo -n "B: "
gzip -dc $DATAFILE					| \
	egrep "${B}.*SYSGRT"				| \
	sort -n -t "|" -k 2				| \
	tail -1						| \
	awk -F '|' '{print $4}'

echo -n "A: "
gzip -dc $DATAFILE					| \
	egrep "${A}.*SYSGRT"				| \
	sort -n -t "|" -k 2				| \
	tail -1						| \
	awk -F '|' '{print $4}'

