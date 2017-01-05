# Pull base image.
FROM bigboards/cdh-base-__arch__

MAINTAINER bigboards
USER root 

RUN apt-get update \
    && apt-get install -y hadoop-yarn-resourcemanager \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

ADD docker_files/resourcemanager-run.sh /apps/resourcemanager-run.sh
RUN chmod a+x /apps/resourcemanager-run.sh

# declare the volumes
RUN mkdir /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

# internal ports
EXPOSE 8030 8031

# external ports
EXPOSE 8032 8033 8088 

CMD ["/apps/resourcemanager-run.sh"]
