#!/bin/bash

source VARS.sh

echo -e "${GREEN}Entering container shell${ENDCOLOR}"
docker attach $CONTAINER_NAME
