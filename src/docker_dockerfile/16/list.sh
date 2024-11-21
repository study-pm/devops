#!/bin/bash

### DESCRIPTION: Lists all containers

source VARS.sh

printf "\033[0;32mContainer run:\033[0m\n"

# List specific container
docker ps -a | grep $LABEL
