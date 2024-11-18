#!/bin/bash

source VARS.sh

echo -e "${BLUE}Running the container${ENDCOLOR}"
docker run -itd --name $LABEL $IMG_NAME /bin/sh
