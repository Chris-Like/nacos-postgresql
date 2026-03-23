FROM eclipse-temurin:17-jdk-jammy
LABEL maintainer="like"

WORKDIR /usr/local/nacos
COPY nacos-server-2.5.0.tar.gz /usr/local/nacos/

RUN tar -zxf nacos-server-2.5.0.tar.gz -C /usr/local/nacos/ && \
    rm -f nacos-server-2.5.0.tar.gz && \

    find /usr/local/nacos/nacos/bin/ -name "*.sh" -exec sed -i 's/\r$//' {} + && \

    chmod +x /usr/local/nacos/nacos/bin/*.sh

ENV NACOS_HOME=/usr/local/nacos/nacos

EXPOSE 31000 32000 32001 30000
CMD ["/bin/bash", "-c", "/bin/bash $NACOS_HOME/bin/startup.sh -m standalone && tail -f $NACOS_HOME/logs/start.out"]