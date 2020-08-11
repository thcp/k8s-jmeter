FROM thclpr/jmeter-base:latest
LABEL maintainer="https://github.com/thcp"

EXPOSE 60000
ENV SSL_DISABLED true
ENV ONE_SHOT true
ENV SLAVE_SVC_NAME jmeter-worker
ENV TESTS_DIR /test

ADD run-test.sh /run-test.sh
RUN chmod +x /run-test.sh \
    && mkdir /test
    
RUN \
    wget https://github.com/NovatecConsulting/JMeter-InfluxDB-Writer/releases/download/v-1.2/JMeter-InfluxDB-Writer-plugin-1.2.jar \
    -O /opt/jmeter/lib/ext/JMeter-InfluxDB-Writer-plugin-1.2.jar

ENTRYPOINT /run-test.sh
