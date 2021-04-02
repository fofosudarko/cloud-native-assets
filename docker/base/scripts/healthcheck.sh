#!/bin/bash
#
# File: healthcheck.sh -> checks health/liveness of application
#
#
# Usage: bash healthcheck.sh HOSTNAME PORT HEALTHCHECK_ENDPOINT
#
#

## - start here

unset HOSTNAME

COMMAND=$0

msg ()
{
  echo >&2 $COMMAND: $1
} 

CURL=`which curl`

[[ -x "$CURL" ]] || { msg "No curl command found"; exit 0; }

if [[ "$#" -ne 3 ]]
then
  msg "expects exactly 3 arguments: HOSTNAME PORT HEALTHCHECK_ENDPOINT"
  exit 0
fi

HOSTNAME=$1
PORT=$2
HEALTHCHECK_ENDPOINT=$3
SCHEME=
HTTPS=${HTTPS:-false}

case "$PORT"
in
  80) SCHEME=http;;
  443) SCHEME=https;;
  *) 
    if [[ "$HTTPS" == "true" ]]
    then
      SCHEME=https
    else
      SCHEME=http
    fi
  ;;
esac

HEALTHCHECK_ENDPOINT=$(sed 's/^\///g' <<< "$HEALTHCHECK_ENDPOINT")

RESPONSE_CODE=$($CURL -sL --insecure "$SCHEME://$HOSTNAME:$PORT/$HEALTHCHECK_ENDPOINT" -o /dev/null -w '%{response_code}')

if [[ "$RESPONSE_CODE" == "404" ]]
then
  msg "healthcheck endpoint '$HEALTHCHECK_ENDPOINT' not found"
  exit 0
fi

if [[ "$RESPONSE_CODE" != "200" ]]
then
  exit 1
fi

exit 0

## -- finish
