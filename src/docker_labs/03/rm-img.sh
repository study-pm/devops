#!/bin/bash

### DESCRIPTION: Removes a docker image

### PARAMS:
# $1: Image version postfix

source VARS.sh

echo -e "${RED}Removing the images${ENDCOLOR}"

docker rmi "$REPO:$1"
