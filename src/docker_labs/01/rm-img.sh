#!/bin/bash

source VARS.sh

echo -e "${RED}Removing the images${ENDCOLOR}"
# Remove images (two commands below are equivavent to docker image remove alias)
docker image rm $IMG_NAME
docker rmi "$IMG_TAG:$IMG_VERSION"


