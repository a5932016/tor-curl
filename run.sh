#!/bin/bash

URL=$1
COUNT=$2
THREAD=$3

set -e

OS="$(uname -s)"

echo "Detected OS: $OS"

if [[ "$OS" == "Linux" ]]; then
    echo "Running on Linux"

    if command -v systemctl >/dev/null 2>&1; then
        if ! systemctl is-active --quiet docker; then
            echo "Starting Docker service..."
            sudo systemctl start docker
        else
            echo "Docker service already running."
        fi
    else
        echo "systemctl not found. Cannot manage Docker service."
        exit 1
    fi

elif [[ "$OS" == "Darwin" ]]; then
    echo "Running on macOS"

    if ! pgrep -f Docker.app >/dev/null 2>&1; then
        echo "Starting Docker Desktop..."
        open -a Docker
    else
        echo "Docker Desktop already running."
    fi

    echo "Waiting for Docker to be ready..."
    until docker info >/dev/null 2>&1; do
        sleep 2
    done
    echo "Docker is ready."
fi

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

wait

echo "done"
