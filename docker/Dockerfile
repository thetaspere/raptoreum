FROM debian:stretch
LABEL maintainer="Theta Developers <dev@theta.org>"
LABEL description="Dockerised ThetaCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
