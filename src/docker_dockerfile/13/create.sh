#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Dockerfile with ONBUILD instruction
base="
FROM busybox\n
ONBUILD RUN echo \"You won't see me until later\"\n
"

echo -en "" $base | sed 's/ //' > base.Dockerfile

# Writing a Dockerfile for creating the downstream image
echo -e "FROM me/no_echo_here" > downstream.Dockerfile
