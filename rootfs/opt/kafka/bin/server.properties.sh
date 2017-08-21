#!/usr/bin/env bash
set -e

KAFKA_DELETE_TOPICS=${KAFKA_DELETE_TOPICS:-"false"}
KAFKA_LOG_DIRS=${KAFKA_LOG_DIRS:-${SERVICE_HOME}"/logs"}
KAFKA_LOG_RETENTION_HOURS=${KAFKA_LOG_RETENTION_HOURS:-"168"}
KAFKA_NUM_PARTITIONS=${KAFKA_NUM_PARTITIONS:-"1"}
KAFKA_ZK_SERVER=${KAFKA_ZK_SERVER:-"127.0.0.1:2181"}
KAFKA_EXT_IP=${KAFKA_EXT_IP:-""}
KAFKA_BROKER_ID=${KAFKA_BROKER_ID:-"0"}
KAFKA_AUTO_CREATE_TOPICS=${KAFKA_AUTO_CREATE_TOPICS:-"true"}
KAFKA_REPLICATION_FACTOR=${KAFKA_REPLICATION_FACTOR:-"1"}
KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=${KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR:-"1"}


if [ ${KAFKA_LISTENER} ];then
  KAFKA_LISTENER="listeners=${KAFKA_LISTENER}"
fi

if [ ${KAFKA_ADVERTISE_LISTENER} ];then
  KAFKA_ADVERTISE_LISTENER="advertised.listeners=${KAFKA_ADVERTISE_LISTENER}"
fi


cat << EOF > ${SERVICE_CONF}
############################# Server Basics #############################
broker.id=${KAFKA_BROKER_ID}
############################# Socket Server Settings #############################
${KAFKA_LISTENER}
${KAFKA_ADVERTISE_LISTENER}
num.network.threads=3
num.io.threads=8
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
############################# Log Basics #############################
log.dirs=${KAFKA_LOG_DIRS}
num.partitions=${KAFKA_NUM_PARTITIONS}
num.recovery.threads.per.data.dir=1
delete.topic.enable=${KAFKA_DELETE_TOPICS}
auto.create.topics.enable=${KAFKA_AUTO_CREATE_TOPICS}
default.replication.factor=${KAFKA_REPLICATION_FACTOR}
offsets.topic.replication.factor=${KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR}
############################# Log Flush Policy #############################
#log.flush.interval.messages=10000
#log.flush.interval.ms=1000
############################# Log Retention Policy #############################
log.retention.hours=${KAFKA_LOG_RETENTION_HOURS}
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
log.cleaner.enable=true
############################# Connect Policy #############################
zookeeper.connect=${KAFKA_ZK_SERVER}
zookeeper.connection.timeout.ms=6000
EOF