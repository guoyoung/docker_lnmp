#!/bin/bash
echo "export LANG=en_US.UTF-8" >> /etc/profile
source /etc/profile

JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -verbose:gc -Xloggc:$LOG_HOME/gc.log "

echo -e "Starting the Server ...\c"
mkdir -p $LOG_HOME
ln -s /data/logs $LOG_HOME

echo "" >>$LOG_HOME/gc.log
java $JAVA_OPTS -jar /data/$JOB

