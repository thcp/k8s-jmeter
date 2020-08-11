#!/bin/bash

set -e

DOCKER_REGISTRY="${DOCKER_REGISTRY:-thclpr}"
TMP_TAG="${TMP_TAG:-dev}"
RELEASE="${RELEASE:-dev}"

options=$(getopt -o bpa --long color: -- "$@")
[ $? -eq 0 ] || { 
    echo "Incorrect options provided"
    exit 1
}

PWD=$(dirname $0)


# Validate
docker_build() {
  docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${TMP_TAG} -f $1 .
}
# Build
docker_publish() {
  for tag in latest "${RELEASE}" ; do
    echo "Tagging $tag"
    docker tag ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${TMP_TAG} ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${tag}
    docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${tag}       
  done
}


selector() {
  if [ "$2" == "base" ]; then
    TARGET="base"
    DOCKER_IMAGE="jmeter-base"
    DOCKER_FILE="$PWD/jmeter-base/Dockerfile"
  elif [ "$2" == "master" ]; then
    TARGET="master"
    DOCKER_IMAGE="jmeter-master"
    DOCKER_FILE="$PWD/jmeter-master/Dockerfile"
  elif [ "$2" == "worker" ]; then
    TARGET="worker"
    DOCKER_IMAGE="jmeter-worker"
    DOCKER_FILE="$PWD/jmeter-worker/Dockerfile"
  fi

  if [ "$1" == "docker_build" ]; then
    docker_build $DOCKER_FILE
  elif [ "$1" == "docker_publish" ]; then
    docker_publish
  fi
}
eval set -- "$options"
while true; do
    case "$1" in
    -b)
      selector docker_build $3
      ;;
    -p)
      selector docker_publish $3
      ;;
    --)
        shift
        break
        ;;
    esac
    shift
done