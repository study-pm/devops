#!/bin/bash

### DESCRIPTION: Display detailed information

### PARAMS:
# $1: Entity type (container, volume, etc)
# $2: Entity (object) name
# S3: Format options

source VARS.sh

printf "${YELLOW}Display information about $1:\n$ENDCOLOR"

docker $1 inspect --format "{{ $3 }}" $2
