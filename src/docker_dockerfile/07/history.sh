#!/bin/bash

### DESCRIPTION: Checks image history by showing its layers

### PARAMS:
# $1: Image name

source VARS.sh

printf "${YELLOW}Checking layers of the image:\n$ENDCOLOR"

docker image history $1
