#!/bin/bash

URL=$1
COUNT=$2
THREAD=$3

if [ -z "$COUNT" ]; then
  COUNT=1
fi

if [ -z "$THREAD" ]; then
  THREAD=1
fi

for i in $(seq 1 $THREAD)
do
  echo "Start Thread: $i"

  docker run -i --rm tor-curl "$URL" "$COUNT" &
done

echo "done"
