#!/bin/bash

### DESCRIPTION: Overrided the existing entrypoint

### PARAMS:
# $1: Docker Image name
# $2: Docker Container name


printf "\033[0;32mOverriding the container entrypoint:\033[0m\n"

docker container run --name $2 \
    --entrypoint "/bin/echo" $1 "Hello, Welcome to Docker Meetup! "
