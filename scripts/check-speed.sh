#!/usr/bin/env bash

set -e;
DATA=$(docker run --rm camalot/speedtest-cli --simple);
DOWNLOAD=$(echo $DATA | awk '/(Download:\s+)([0-9]+\.[0-9]+)\s(Mbit\/s)/ {print $2}');
UPLOAD=$(echo $DATA | awk '/(Upload:\s+)([0-9]+\.[0-9]+)\s(Mbit\/s)/ {print $2}');
PING=$(echo $DATA | awk '/(Ping:\s+)([0-9]+\.[0-9]+)\s(ms)/ {print $2}');
RESULT=0;
MESSAGE="OK: Ping: $PING ms | Download: $DOWNLOAD Mbit/s | Upload: $UPLOAD Mbit/s";

DLOW=100;
DMID=400;
ULOW=5;
UMID=25;
PHIGH=50;
PMID=25;

if [ $(echo $DLOW'>'$DOWNLOAD | bc -l) == 1 ]; then
	RESULT=2;
	MESSAGE="ERROR: Download Speed below $DLOW Mbit/s (Ping: $PING ms | Download: $DOWNLOAD Mbit/s | Upload: $UPLOAD Mbit/s)";
elif [ $(echo $DMID'>'$DOWNLOAD | bc -l) == 1 ]; then
	RESULT=1;
	MESSAGE="WARNING: Download Speed below $DMID Mbit/s (Ping: $PING ms | Download: $DOWNLOAD Mbit/s | Upload: $UPLOAD Mbit/s)";
elif [ $(echo $ULOW'>'$UPLOAD | bc -l) == 1 ]; then
	RESULT=2;
	MESSAGE="ERROR: Upload Speed below $DLOW Mbit/s (Ping: $PING ms | Download: $DOWNLOAD Mbit/s | Upload: $UPLOAD Mbit/s)";
elif [ $(echo $UMID'>'$UPLOAD | bc -l) == 1 ]; then
	RESULT=1;
	MESSAGE="WARNING: Upload Speed below $DMID Mbit/s (Ping: $PING ms | Download: $DOWNLOAD Mbit/s | Upload: $UPLOAD Mbit/s)";
elif [ $(echo $PING'>'$PHIGH | bc -l) == 1 ]; then
	RESULT=2;
	MESSAGE="ERROR: Upload Speed below $PHIGH ms (Ping: $PING ms | Download: $DOWNLOAD Mbit/s | Upload: $UPLOAD Mbit/s)";
elif [ $(echo $PING'>'$PMID | bc -l) == 1 ]; then
	RESULT=1;
	MESSAGE="WARNING: Ping is above $PMID ms (Ping: $PING ms | Download: $DOWNLOAD Mbit/s | Upload: $UPLOAD Mbit/s)";
fi

echo "$RESULT:$SPEED:$MESSAGE";

