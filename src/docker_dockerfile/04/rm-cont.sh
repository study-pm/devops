#!/bin/bash

### DESCRIPTION: Removes a docker container

### PARAMS:
# $1: Container name

source VARS.sh

# Force remove the container
echo -e "${RED}Removing the container${ENDCOLOR}"
docker rm -f $1
