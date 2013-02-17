#!/bin/sh
#
# Usage: ./read.sh [/dev/dvd [prefix]]

export PATH="$PATH:$HOME/src/OTHER/libdvdread/dvd/libdvdread-0.9.7/src/"

SRC="${1:-/dev/dvd}"

oops()
{
echo "Error: $*" >&2
exit 1
}

getid()
{
disc_id "$SRC"
}

gettitle()
{
lsdvd "$SRC" | sed -n '1s/^[^:]*: //p'
}

gettracks()
{
title_info "$SRC" | sed -n '1s/^[^0-9]*\([0-9]*\)[^0-9].*$/\1/p'
}

getangles()
{
lsdvd -n -t "$1" "$SRC" | sed -n 's/^[[:space:]][^0-9]*//p'
}

ID="`getid`"
TITLE="`gettitle`"
[ -n "$TITLE" ] || TITLE=unknown
TRACKS="`gettracks`"

[ -n "$TRACKS" ] || exit 1

TIT="$2$TITLE"
TO="$TIT-$ID"
PREF="$TO/$TIT"

[ ! -d "$TO" ] || echo "exists: $TO"
[ -d "$TO" ] || mkdir "$TO" || oops "cannot create $TO"

[ -f "$PREF.info" ] && mv -v --backup=t "$PREF.info" "$PREF.info.old"
env DVDCSS_VERBOSE=2 title_info "$SRC" >"$PREF.info" 2>&1

i=0
while   let i++
	[ $i -le $TRACKS ]
do
	angles="`getangles "$i"`" || oops "angles"
	ii="`printf %02d $i`"
	j=0
	while   let j++
		[ $j -le "$angles" ]
	do
		out="$PREF.$ii-$j"
		if [ -s "$out.mpg" ]
		then
			echo "Existing $TITLE $i $j"
			continue
		fi
		echo "Reading $TITLE $i $j"
		#env DVDCSS_VERBOSE=2 play_title "$SRC" $i 1 $j | count-fcb0 > "$out.$$.tmp"
		env DVDCSS_VERBOSE=2 play_title "$SRC" $i 1 $j 2>>"$out.log" | buffer -m 4m -s 2k -S 1m > "$out.$$.tmp"
		echo "Finished"
		#mvatom "$out.$$" "$out"
		mv --backup=t "$out.$$.tmp" "$out.mpg"
	done
done

eject "$SRC"

echo "stored: $TO"
