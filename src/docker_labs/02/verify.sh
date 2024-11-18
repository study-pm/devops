#!/bin/bash

source VARS.sh

printf "\033[0;32mCreated images:\033[0m\n"
docker images | grep $NAMESPACE
