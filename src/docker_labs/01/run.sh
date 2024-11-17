#!/bin/bash

source VARS.sh

echo -e "${BLUE}Running the container${ENDCOLOR}"
docker run -itd --name $CONTAINER_NAME "$IMG_TAG:$IMG_VERSION" /bin/sh
