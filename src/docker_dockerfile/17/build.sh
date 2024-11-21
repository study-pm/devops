#!/bin/bash

### DESCRIPTION: Builds docker images from Dockerfiles

### PARAMS:
# $1: Image name
# $2: Dockerfile name

docker build -t $1 . -f ${2-Dockerfile}
