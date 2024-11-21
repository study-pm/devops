#!/bin/bash

### DESCRIPTION: Checks the created images

source VARS.sh

printf "${GREEN}Created images:\033[0m\n$ENDCOLOR"
docker images | grep $NAMESPACE
