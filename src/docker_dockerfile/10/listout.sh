#!/bin/bash

### DESCRIPTION: List volumes

### PARAMS:
# $1: Container name

source VARS.sh

printf "${GREEN}Volumes in the host:\n$ENDCOLOR"

docker volume ls
