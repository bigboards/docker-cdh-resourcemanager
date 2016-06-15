# Pull base image.
#FROM bigboards/cdh-base-__arch__
FROM bigboards/cdh-base-x86_64

MAINTAINER bigboards
USER root 

RUN apt-get update && apt-get install -y hadoop-yarn-resourcemanager 

ADD docker_files/resourcemanager-run.sh /apps/resourcemanager-run.sh
RUN chmod a+x /apps/resourcemanager-run.sh

# internal ports
EXPOSE 8030 8031

# external ports
EXPOSE 8032 8033 8088 

CMD ["/apps/resourcemanager-run.sh"]
