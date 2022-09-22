FROM debian:stretch
LABEL maintainer="Theta Developers <soosho@thetaspere.com>"
LABEL description="Dockerised ThetaCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
