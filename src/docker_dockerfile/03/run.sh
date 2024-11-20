#!/bin/bash

### DESCRIPTION: Starts a docker container

### PARAMS:
# $1: Container version postfix
# $2: Host port number
# $3: Docker image name
# $4: Container's port number (defaults to 80)

source VARS.sh

echo -e "${BLUE}Running the container${ENDCOLOR}"
docker run -d --rm --name "$LABEL$1" -p $2:${4:-80} $3
