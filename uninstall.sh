#!/bin/bash

docker stop $(docker ps --filter "ancestor=tor-curl" -q) 2>/dev/null || true
docker rm $(docker ps -a --filter "ancestor=tor-curl" -q) 2>/dev/null || true

docker rmi tor-curl 2>/dev/null || true