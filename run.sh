#!/bin/bash

URL=$1
COUNT=$2
THREAD=$3

for i in $(seq 1 $THREAD)
do
  echo "Start Thread: $i"

  docker run -i --rm tor-curl "$URL" "$COUNT" &

  sleep 1
done

echo "done"
