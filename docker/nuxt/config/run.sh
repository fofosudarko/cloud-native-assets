#!/bin/bash
#
# File: run.sh -> runs server
#
#
# Usage: sh run.sh
#
#

## - start here

APP_WORKDIR=${APP_WORKDIR:-/app}
APP_SERVER_HOST=${APP_SERVER_HOST:-'localhost'}
APP_SERVER_PORT=${APP_SERVER_PORT:-5000}
APP_BUILD_MODE=${APP_BUILD_MODE:-'spa'}
APP_NAME=${APP_NAME:-'nuxt-app'}
APP_RUN_COMMAND=${APP_RUN_COMMAND:-'nuxt start'}

which serve > /dev/null 2>&1 || exit 1

if [[ "$APP_BUILD_MODE" == "spa" ]]
then
  serve --single --listen tcp://${APP_SERVER_HOST}:${APP_SERVER_PORT} /app/server
elif [[ "$APP_BUILD_MODE" == "universal" ]]
then
  cd $APP_WORKDIR
  HOST=${APP_SERVER_HOST} PORT=${APP_SERVER_PORT} npx $APP_RUN_COMMAND
else
  echo >&2 "$0: build mode '$APP_BUILD_MODE' unknown"
  exit 1
fi

exit 0

## -- finish
