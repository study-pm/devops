#!/bin/bash

### DESCRIPTION: Starts a docker container

### PARAMS:
# $1: Docker image name
# $2: Tag (defaults to "latest")
# $3: Container name

source VARS.sh

echo -e "${BLUE}Running the container${ENDCOLOR}"
docker run --name $3 "$1:${2:-latest}"
