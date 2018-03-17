#!/usr/bin/env bash

set -e;
SPEED=$(docker run --rm camalot/speedtest-cli -- --no-upload --simple | awk '/(Download:\s+)([0-9]+\.[0-9]+)\s([KMG]bit\/s)/ {print $2}');
RESULT=0;
MESSAGE="OK: Download: $SPEED Mbit/s";
LOW=100;
MID=400;

if [ $(echo $LOW'>'$SPEED | bc -l) == 1 ]; then
        RESULT=2;
        MESSAGE="ERROR: Download Speed below $LOW Mbit/s (Download $SPEED Mbit/s)";
elif [ $(echo $MID'>'$SPEED | bc -l) == 1 ]; then
        RESULT=1;
        MESSAGE="WARNING: Download Speed below $MID Mbit/s (Download: $SPEED Mbit/s)";
fi

echo "$RESULT:$SPEED:$MESSAGE";

unset SPEED;
unset RESULT;
unset MESSAGE;
unset LOW;
unset MID;
