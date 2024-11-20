#!/bin/bash

### DESCRIPTION: Removes a docker image

### PARAMS:
# $1: Image name

source VARS.sh

echo -e "${RED}Removing the images${ENDCOLOR}"
docker rmi $1
