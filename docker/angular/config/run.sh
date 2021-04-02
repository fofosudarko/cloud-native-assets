#!/bin/bash
#
# File: run.sh -> runs server
#
#
# Usage: sh run.sh
#
#

## - start here

APP_SERVER_HOST=${APP_SERVER_HOST:-'localhost'}
APP_SERVER_PORT=${APP_SERVER_PORT:-5000}

which serve > /dev/null 2>&1 || exit 1

serve --single --listen tcp://${APP_SERVER_HOST}:${APP_SERVER_PORT} /app/server

exit 0

## -- finish
