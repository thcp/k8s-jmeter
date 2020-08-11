FROM thclpr/jmeter-base:latest
LABEL maintainer="https://github.com/thcp"

EXPOSE 1099 60001
ENV SSL_DISABLED true

ENTRYPOINT jmeter-server -Dserver.rmi.localport=60001 -Dserver_port=1099 \
            -Jserver.rmi.ssl.disable=${SSL_DISABLED}
