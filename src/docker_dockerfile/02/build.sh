#!/bin/bash

source VARS.sh

docker build -t $IMG_PATH . -f $DOCKERFILE
