#!/bin/bash
#
# File: run.sh -> runs server
#
#
# Usage: sh run.sh
#
#

## - start here

APP_WORKDIR=${APP_WORKDIR:-'/app'}
APP_SERVER_HOST=${APP_SERVER_HOST:-'localhost'}
APP_SERVER_PORT=${APP_SERVER_PORT:-5000}
APP_BUILD_MODE=${APP_BUILD_MODE:-'spa'}
APP_NAME=${APP_NAME:-'next-app'}
APP_RUN_COMMAND=${APP_RUN_COMMAND:-'next start'}

which serve > /dev/null 2>&1 || exit 1

if [[ "$APP_BUILD_MODE" == "spa" ]]
then
  serve --listen tcp://${APP_SERVER_HOST}:${APP_SERVER_PORT} /app/server
elif [[ "$APP_BUILD_MODE" == "universal" ]]
then
  cd $APP_WORKDIR
  npx $APP_RUN_COMMAND -H ${APP_SERVER_HOST} -p ${APP_SERVER_PORT}
fi

exit 0

## -- finish