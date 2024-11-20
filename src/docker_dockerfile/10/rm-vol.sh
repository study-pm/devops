#!/bin/bash

### DESCRIPTION: Removes all unused local volumes

### PARAMS:
# $1: Volume name

source VARS.sh

echo -e "${RED}Removing the volume${ENDCOLOR}"
docker volume rm $1
