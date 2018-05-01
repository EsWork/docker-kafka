FROM openjdk:8-jre-alpine

ENV SERVICE_HOME=/opt/kafka \
    SERVICE_NAME=kafka \
    SERVICE_USER=kafka \
    SERVICE_GROUP=kafka \
    SERVICE_UID=1000 \
    SERVICE_GID=1000 \
    SERVICE_VERSION=1.1.0 \
    SCALA_VERSION=2.12 
ENV KAFKA_LOG_DIRS=/opt/kafka/logs \
    PATH=${SERVICE_HOME}/bin:${PATH} \
    SERVICE_CONF=${SERVICE_HOME}/config/server.properties \
    SERVICE_URL=http://apache.mirrors.spacedump.net/kafka 

LABEL description="kafka built from source" \
      kafka="kafka ${SERVICE_VERSION}" \
      maintainer="JohnWu <v.la@live.cn>"

#china mirrors repos
# RUN echo "https://mirrors.ustc.edu.cn/alpine/latest-stable/main" > /etc/apk/repositories \
# &&  echo "https://mirrors.ustc.edu.cn/alpine/latest-stable/community" >> /etc/apk/repositories

RUN  apk -U upgrade && apk add --update --no-cache bash libressl su-exec curl && mkdir /opt \
&& curl -sS -k ${SERVICE_URL}/${SERVICE_VERSION}/kafka_${SCALA_VERSION}-${SERVICE_VERSION}.tgz | gunzip -c - | tar -xf - -C /opt \
&& mv /opt/kafka_${SCALA_VERSION}-${SERVICE_VERSION} ${SERVICE_HOME} \
&& mkdir ${SERVICE_HOME}/data ${SERVICE_HOME}/logs \
&& addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} \
&& adduser -g "${SERVICE_NAME} user" -D -h ${SERVICE_HOME} -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER} \
# cleanup
&& rm /var/cache/apk/*

ADD rootfs /
RUN chmod +x ${SERVICE_HOME}/bin/*.sh \
  && chown -R ${SERVICE_USER}:${SERVICE_GROUP} ${SERVICE_HOME}

WORKDIR $SERVICE_HOME

EXPOSE 9092

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["kafka-server-start.sh"]