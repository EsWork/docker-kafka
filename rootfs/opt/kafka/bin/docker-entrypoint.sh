#!/usr/bin/env bash
set -e

function log() {
  echo `date` $ME - $@
}

if [ "$1" = 'kafka-server-start.sh' ]; then
log "[ Starting ${SERVICE_NAME}... ]"
${SERVICE_HOME}/bin/server.properties.sh
chown -R ${SERVICE_USER}:${SERVICE_GROUP} ${KAFKA_LOG_DIRS}
exec su-exec ${SERVICE_USER}:${SERVICE_GROUP} "$@" ${SERVICE_CONF}
fi

exec "$@"