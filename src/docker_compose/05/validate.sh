#!/bin/bash

### DESCRIPTION: Validates the compose configuration

source CONST.sh

echo -e "${YELLOW}Validating the docker compose file${ENDCOLOR}"
docker compose config
