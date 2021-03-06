#!/bin/bash

doDatabaseMigrations ()
{
  # do database migrations
  npx sequelize db:migrate
}

buildPostgresURI ()
{
  echo -ne "postgres://$POSTGRES_USERNAME:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DBNAME?$POSTGRES_CONNECTION_QUERY_STRING"
}

buildAppEnv ()
{
  cat > $APP_ENVFILE <<EOF
HOST=${APP_SERVER_HOST:-$HOST}
PORT=${APP_SERVER_PORT:-$PORT}
NODE_ENV=${APP_SERVER_ENV:-$NODE_ENV}
POSTGRES_USERNAME=$POSTGRES_USERNAME
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
POSTGRES_DBNAME=$POSTGRES_DBNAME
POSTGRES_HOST=$POSTGRES_HOST
POSTGRES_PORT=$POSTGRES_PORT
KAFKA_BOOTSTRAP_SERVERS=$KAFKA_BOOTSTRAP_SERVERS
POSTGRES_URI=$(buildPostgresURI)
REDIS_HOST=$REDIS_HOST
REDIS_PORT=$REDIS_PORT
REDIS_PASSWORD=$REDIS_PASSWORD
SENDGRID_URL=$SENDGRID_URL
SENDGRID_FROM_EMAIL=$SENDGRID_FROM_EMAIL
SENDGRID_API_KEY=$SENDGRID_API_KEY
EOF

  return 0
}

loadAppEnv ()
{
  [[ -e "$APP_ENVFILE" ]] && source $APP_ENVFILE
}

runApp ()
{
  cd $APP_WORKDIR

  # compile app
  tsc -p $APP_WORKDIR/tsconfig.json

  # run app
  ts-node $APP_WORKDIR/compiled
}

APP_ENVFILE=$APP_WORKDIR/.env

buildAppEnv && loadAppEnv
doDatabaseMigrations
runApp