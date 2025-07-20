#!/bin/sh

URL=$1
COUNT=$2

if [ -z "$URL" ]; then
  echo "Error URL"
  exit 1
fi

if [ -z "$COUNT" ]; then
  COUNT=1
fi

echo "Start Tor"

for i in $(seq 1 $COUNT)
do
  echo "Requesr: $i"

  tor > /dev/null &

  while ! nc -z 127.0.0.1 9050; do
    echo "wait"
    sleep 1
  done

  curl -s -L \
    --socks5-hostname 127.0.0.1:9050 \
    -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" \
    -H "Accept-Language: zh-TW,zh;q=0.9,en-US;q=0.8,en;q=0.7" \
    -H "Connection: keep-alive" \
    -H "Upgrade-Insecure-Requests: 1" \
    --compressed \
    "$URL"

  killall -HUP tor

  echo ""

done

echo "done"
