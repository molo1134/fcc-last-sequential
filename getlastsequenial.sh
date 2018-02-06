#!/bin/sh

DISTRICT=$1
if [ ! "$DISTRICT" ]; then
	DISTRICT='1'
fi

if [ "$DISTRICT" = "10" ]; then
	DISTRICT='0'
fi

A="A[^HL-Z]${DISTRICT}[A-Z]{2}\\>"
B="K[^HLP]${DISTRICT}[A-Z]{2}\\>"
D="K[^HLP]${DISTRICT}[A-Z]{3}\\>"

# Alaska
if [ "$DISTRICT" = "11" -o "$DISTRICT" = "AK" -o "$DISTRICT" = "KL" ]; then
	A="[AKNW]L[0-9][A-Z]\\>"
	B="AL[0-9][A-Z]{2}\\>"
	C="[KNW]L[0-9][A-Z]{2}\\>"
	D="[KNW]L[0-9][A-Z]{3}\\>"
fi

# PR/USVI
if [ "$DISTRICT" = "12" ]; then
	A="[KNW]P[234][A-Z]\\>"
	B="KP[234][A-Z]{2}\\>"
	C="[NW]P[234][A-Z]{2}\\>"
	D="[KNW]P[234][A-Z]{3}\\>"
fi

# PR
if [ "$DISTRICT" = "PR" -o "$DISTRICT" = "KP4" ]; then
	A="[KNW]P[34][A-Z]\\>"
	B="KP[34][A-Z]{2}\\>"
	C="[NW]P[34][A-Z]{2}\\>"
	D="[KNW]P[34][A-Z]{3}\\>"
fi

# USVI
if [ "$DISTRICT" = "VI" -o "$DISTRICT" = "USVI" -o "$DISTRICT" = "KP2" ]; then
	A=
	B="KP2[A-Z]{2}\\>"
	C="[NW]P2[A-Z]{2}\\>"
	D="[KNW]P2[A-Z]{3}\\>"
fi

# Hawaii/Pacific
if [ "$DISTRICT" = "13" ]; then
	A="[AKNW]H[02678][A-Z]\\>"
	B="AH[02678][A-Z]{2}\\>"
	C="[KNW]H[02678][A-Z]{2}\\>"
	D="[KNW]H[02678][A-Z]{3}\\>"
fi


# Hawaii
if [ "$DISTRICT" = "HI" -o "$DISTRICT" = "KH6" ]; then
	A=
	B="AH[67][A-Z]{2}\\>"
	C="[KNW]H[67][A-Z]{2}\\>"
	D="[KNW]H[67][A-Z]{3}\\>"
fi

# Guam
if [ "$DISTRICT" = "GU" -o "$DISTRICT" = "KH2" ]; then
	A="[AKNW]H2[A-Z]\\>"
	A=
	B="AH2[A-Z]{2}\\>"
	C="[KNW]H2[A-Z]{2}\\>"
	D="[KNW]H2[A-Z]{3}\\>"
fi

# American Samoa
if [ "$DISTRICT" = "AS" -o "$DISTRICT" = "KH8" ]; then
	A="[AKNW]H8[A-Z]\\>"
	B="AH8[A-Z]{2}\\>"
	B=
	C="[KNW]H8[A-Z]{2}\\>"
	D="[KNW]H8[A-Z]{3}\\>"
fi

# Northern Mariana
if [ "$DISTRICT" = "MP" -o "$DISTRICT" = "KH0" ]; then
	A="[AKNW]H0[A-Z]\\>"
	B="AH0[A-Z]{2}\\>"
	C="[KNW]H0[A-Z]{2}\\>"
	D="[KNW]H0[A-Z]{3}\\>"
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

if [ "$B" ]; then
	echo -n "B: "
	gzip -dc $DATAFILE					| \
		egrep "${B}.*SYSGRT"				| \
		sort -n -t "|" -k 2				| \
		tail -1						| \
		awk -F '|' '{print $4}'
fi

if [ "$A" ]; then
	echo -n "A: "
	gzip -dc $DATAFILE					| \
		egrep "${A}.*SYSGRT"				| \
		sort -n -t "|" -k 2				| \
		tail -1						| \
		awk -F '|' '{print $4}'
fi
