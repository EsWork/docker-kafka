[![Build Status](https://travis-ci.org/EsWork/docker-kafka.svg?branch=master)](https://travis-ci.org/EsWork/docker-kafka) 

|Image Tag | Metadata from image |
|--------- | :------------ |
|[![](https://images.microbadger.com/badges/version/eswork/kafka.svg)](https://microbadger.com/images/eswork/kafka "Get your own version badge on microbadger.com")|[![](https://images.microbadger.com/badges/image/eswork/kafka.svg)](https://microbadger.com/images/eswork/kafka "Get your own image badge on microbadger.com")

## Supported tags and respective `Dockerfile` links

- [`latest` , `0.11.0.0` (0.11.0.0/Dockerfile)](https://github.com/EsWork/docker-kafka/blob/master/Dockerfile)

* eswork/kafka

Environment variables
---

- **SERVICE_USER** : kafka user name *(default : kafka)*
- **SERVICE_GROUP** : kafka group name *(default : kafka)*
- **SERVICE_UID** : kafka user id *(default : 1000)*
- **SERVICE_GID** : kafka group id *(default : 1000)*
- **SERVICE_HOME** : kafka home *(default : /opt/kafka)*

- KAFKA_HEAP_OPTS=${JVMFLAGS:-"-Xmx1G -Xms1G"}     				                            # Kafka memory value (optional)
- KAFKA_LISTENER=	                                                                    # Listerner string
- KAFKA_ADVERTISE_LISTENER=	                                                          # Listerner advertised string 
- KAFKA_DELETE_TOPICS=${KAFKA_DELETE_TOPICS:-"false"}			                            # Enable kafka delete topics
- KAFKA_LOG_DIRS=${KAFKA_LOG_DIRS:-"${SERVICE_HOME}/logs"}		                        # Log directories.
- KAFKA_LOG_RETENTION_HOURS=${KAFKA_LOG_RETENTION_HOURS:-"168"}	                      # Log retention hours
- KAFKA_NUM_PARTITIONS=${KAFKA_NUM_PARTITIONS:-"1"}				                            # Number of partitions
- KAFKA_ZK_SERVER=${KAFKA_ZK_SERVER:-"127.0.0.1:2181"}					                      # Zk Server
- KAFKA_EXT_IP=${KAFKA_EXT_IP:-""}								                                    # Advertise external ip or name if value != ""
- KAFKA_AUTO_CREATE_TOPICS=${KAFKA_AUTO_CREATE_TOPICS:-"true"}	                      # Auto create topics
- KAFKA_REPLICATION_FACTOR=${KAFKA_REPLICATION_FACTOR:-1}		                          # Replication factor
- KAFKA_BROKER_ID=${KAFKA_BROKER_ID:-"0"}                                             # broker id
- KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=${KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR:-1} # topic Backup copies

Installation
---
```bash
docker pull eswork/kafka
```

Quickstart
---

```bash
docker run --name kafka -d \
-v /etc/localtime:/etc/localtime:ro \
-p 9092:9092 --restart=always \
-e KAFKA_ZK_SERVER="192.168.0.244:2181" \
eswork/kafka 
```