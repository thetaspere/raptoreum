#!/usr/bin/env bash

export LC_ALL=C

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/.. || exit

DOCKER_IMAGE=${DOCKER_IMAGE:-theta/thetad-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/thetad docker/bin/
cp $BUILD_DIR/src/theta-cli docker/bin/
cp $BUILD_DIR/src/theta-tx docker/bin/
strip docker/bin/thetad
strip docker/bin/theta-cli
strip docker/bin/theta-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
