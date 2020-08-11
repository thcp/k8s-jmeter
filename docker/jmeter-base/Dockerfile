FROM alpine:3.12
LABEL maintainer="https://github.com/thcp"

ENV JMETER_VERSION "4.0"

RUN apk update && \
    apk upgrade && \
    apk add --update openjdk8-jre wget tar bash && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    mkdir -p /opt/jmeter && \
    tar -zxf apache-jmeter-${JMETER_VERSION}.tgz -C /opt/jmeter/  --strip-components=1 && \
    rm -rf apache-jmeter-${JMETER_VERSION}.tgz && \
    rm -rf /var/cache/apk/*

ENV JMETER_HOME /opt/jmeter
ENV PATH $PATH:$JMETER_HOME/bin
