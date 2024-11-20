#!/bin/bash

source VARS.sh

# Stop running container
# docker stop $CONTAINER_NAME

# Remove the container
# docker rm $CONTAINER_NAME

# Force remove the container
echo -e "${RED}Removing the container${ENDCOLOR}"
docker rm -f $CONTAINER_NAME
