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

# function serviceStart() {
#   log "[ Starting ${SERVICE_NAME}... ]"
#   ${SERVICE_HOME}/bin/server.properties.sh

#   # if [ ! -L ${SERVICE_LOG_FILE} ]; then
#   #       rm ${SERVICE_LOG_FILE}
#   #       # ln -sf /dev/stderr ${SERVICE_LOG_FILE}
#   #       # ln -sf /proc/1/fd/1 ${SERVICE_LOG_FILE}
#   # fi

#   ${SERVICE_HOME}/bin/kafka-server-start.sh ${SERVICE_CONF}
# }

exec "$@"