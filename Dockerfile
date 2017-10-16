FROM jenkinsci/jnlp-slave:latest
MAINTAINER Bensonz <mr.bz@hotmail.com>

LABEL Description="This is custom jenkins slave image based on the original image, with docker client and kubectl installed"

ARG DOCKER_VERSION=17.09.0-ce
ARG S3_BUCKET=s3.cn-north-1.amazonaws.com.cn/kubernetes-bin

USER root

RUN curl "https://${S3_BUCKET}/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
  && tar -xzvf docker.tgz \
  && mv docker/* /usr/local/bin/ \
  && rmdir docker \
  && rm docker.tgz

COPY launch.sh /
RUN chmod +x /launch.sh && sh /launch.sh && rm /launch.sh


VOLUME ["/var/run/docker.sock"]

ENTRYPOINT ["jenkins-slave"]
