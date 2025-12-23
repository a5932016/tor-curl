#!/bin/bash

docker ps -a --filter "ancestor=tor-curl" -q | xargs -r docker rm -f