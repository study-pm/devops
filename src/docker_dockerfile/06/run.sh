#!/bin/bash

### DESCRIPTION: Starts a docker container

### PARAMS:
# $1: Container name
# $2: Image name
# $3: Tag (defaults to "latest")

source VARS.sh

echo -e "${BLUE}Running the container${ENDCOLOR}"
docker run --name $1 -it "$2:${3:-latest}" pwd
