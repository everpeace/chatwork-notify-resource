#!/bin/bash

CONTAINER_NAME=chatwork-notify-resource
DOCKER_HUB_ORG=everpeace

docker build --no-cache -t $CONTAINER_NAME .
docker tag -f $CONTAINER_NAME $DOCKER_HUB_ORG/$CONTAINER_NAME
docker push $DOCKER_HUB_ORG/$CONTAINER_NAME
