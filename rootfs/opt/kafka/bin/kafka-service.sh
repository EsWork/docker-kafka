#!/usr/bin/env bash
set -e

SERVICE_LOG_DIR=${KAFKA_LOG_DIRS:-${SERVICE_HOME}"/logs"}
SERVICE_LOG_FILE=${SERVICE_LOG_FILE:-${SERVICE_LOG_DIR}"/server.log"}

function log() {
  echo `date` $ME - $@
}

function serviceStart() {
  log "[ Starting ${SERVICE_NAME}... ]"
  ${SERVICE_HOME}/bin/server.properties.sh

  # if [ ! -L ${SERVICE_LOG_FILE} ]; then
  #       rm ${SERVICE_LOG_FILE}
  #       # ln -sf /dev/stderr ${SERVICE_LOG_FILE}
  #       # ln -sf /proc/1/fd/1 ${SERVICE_LOG_FILE}
  # fi

  ${SERVICE_HOME}/bin/kafka-server-start.sh ${SERVICE_CONF}
}

function serviceStop() {
  log "[ Stoping ${SERVICE_NAME}... ]"
  pid=`ps ax | grep java | grep server | grep -v grep | awk '{print $1}'`
  while [ "x$pid" != "x" ]; do
    	kill -SIGTERM $pid
    	sleep 5 
    	pid=`ps ax | grep java | grep server | grep -v grep | awk '{print $1}'`
	done
}

function serviceRestart() {
  log "[ Restarting ${SERVICE_NAME}... ]"
  serviceStop
  serviceStart
}

case "$1" in
        "start")
            serviceStart
        ;;
        "stop")
            serviceStop
        ;;
        "restart")
            serviceRestart
        ;;
        *) 
            echo "Usage: $0 restart|start|stop"
            exit 1
        ;;

esac

exit 0