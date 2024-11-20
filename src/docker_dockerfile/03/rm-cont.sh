#!/bin/bash

### DESCRIPTION: Removes a docker container

### PARAMS:
# $1: Container version postfix

source VARS.sh

# Force remove the container
echo -e "${RED}Removing the container${ENDCOLOR}"
docker rm -f "$LABEL$1"
