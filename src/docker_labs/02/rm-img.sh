#!/bin/bash

source VARS.sh

echo -e "${RED}Removing the images${ENDCOLOR}"
# Remove images (two commands below are equivavent to docker image remove alias)
docker rmi $IMG_PATH
docker rmi $IMG_NAME
