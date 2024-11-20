#!/bin/bash

### DESCRIPTION: Checks containerized server connectivity

### PARAMS:
# $1: host port number (defaults to 80)

printf "\033[0;32mChecking server connectivity:\033[0m\n"

curl localhost:${1:-80}
