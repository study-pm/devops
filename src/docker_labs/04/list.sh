#!/bin/bash

### DESCRIPTION: Lists all containers

source VARS.sh

# List all containers (running and stopped)
# docker ps -a

printf "\033[0;32mContainer run:\033[0m\n"

# List specific container
docker ps | grep $LABEL
