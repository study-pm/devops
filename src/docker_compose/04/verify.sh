#!/bin/bash

### DESCRIPTION: Checks the created images

### PARAMS:
# $1: Image name
# $2: Image tag

source CONST.sh

printf "${GREEN}Created images:\033[0m\n$ENDCOLOR"
docker image ls $1:${2-latest}
