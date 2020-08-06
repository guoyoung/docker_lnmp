FROM openjdk:8
ENV LOG_HOME=/Users/gy/data/java/logs/wenyi/mqtt
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
RUN mkdir -p $LOG_HOME && ln -s /data/logs $LOG_HOME
RUN echo "" >>$LOG_HOME/gc.log
WORKDIR /data
ENTRYPOINT ["java","-XX:MaxRAMFraction=1 -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -verbose:gc -Xloggc:$LOG_HOME/gc.log","-jar","/data/mqtt.jar"]