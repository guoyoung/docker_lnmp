FROM openjdk:8
ENV JOB=mqtt.jar
ENV LOG_HOME=/Users/gy/data/java/logs/wenyi/mqtt
ADD ./run.sh /data
RUN chmod a+x /data/run.sh
WORKDIR /data
ENTRYPOINT sh /data/run.sh