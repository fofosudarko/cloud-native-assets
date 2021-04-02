#!/bin/bash
#
# File: run.sh -> do database migrations and run app
#
# Usage: sh run.sh
#
#

## - start here

doDatabaseMigrations ()
{
  if [[ ! -d "$APP_SERVER_MIGRATIONS_FOLDER" ]]
  then
    (
      flask db init;
      flask db migrate --message 'initial commit'
    ) || return 1
  fi

  flask db upgrade || return 1
  
  return 0
}

runApp ()
{
  gunicorn \
    --log-level ${APP_SERVER_LOG_LEVEL} \
    --log-syslog \
    --capture-output \
    --workers ${APP_SERVER_WORKERS} \
    --worker-connections ${APP_SERVER_WORKER_CONNECTIONS} \
    --bind ${APP_SERVER_HOST}:${APP_SERVER_PORT} "${APP_SERVER_ENTRY_POINT}"
}

APP_SERVER_PORT=${APP_SERVER_PORT:-5000}
APP_SERVER_DEBUG=${APP_SERVER_DEBUG:-1}
APP_SERVER_ENV=${APP_SERVER_ENV:-'development'}
APP_SERVER_HOST=${APP_SERVER_HOST:-'localhost'}
APP_SERVER_WORKERS=${APP_SERVER_WORKERS:-1}
APP_SERVER_WORKER_CONNECTIONS=${APP_SERVER_WORKER_CONNECTIONS:-1000}
APP_SERVER_LOG_LEVEL=${APP_SERVER_LOG_LEVEL:-'error'}

POSTGRES_USERNAME=${POSTGRES_USERNAME}
POSTGRES_DBNAME=${POSTGRES_DBNAME}
POSTGRES_PORT=${POSTGRES_PORT}
POSTGRES_HOST=${POSTGRES_HOST}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

which flask > /dev/null || exit 1
which gunicorn > /dev/null || exit 1

doDatabaseMigrations && runApp

exit 0

## -- finish
