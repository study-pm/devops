#!/bin/bash

### DESCRIPTION: Display detailed information

### PARAMS:
# $1: Entity type (container, volume, etc)
# S2: Format options
# $3: Entity (object) name


source VARS.sh

printf "${YELLOW}Display information about $1:\n$ENDCOLOR"

docker $1 inspect --format="{{ $2 }}" $3
