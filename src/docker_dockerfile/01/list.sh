#!/bin/bash

source VARS.sh

# List all containers
# docker ps -a

printf "\033[0;32mContainer run:\033[0m\n"

# List specific container
docker ps | grep $CONTAINER_NAME
