#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

source VARS.sh

# Create an image with RUN instruction
v1="
FROM alpine:3.9.3\n
LABEL maintainer=\"Collabnix\"\n
RUN apk add --update\n
RUN apk add curl\n
RUN rm -rf /var/cache/apk/\n
"

echo -en "" $v1 | sed 's/ //' > build1.Dockerfile

# Combining multiple RUN instruction to one
v2="
FROM alpine:3.9.3\n
LABEL maintainer=\"Collabnix\"\n
RUN apk add --update && \\ \n
\tapk add curl  && \\ \n
\trm -rf /var/cache/apk/\n
"

echo -en "" $v2 | sed 's/ //'  > build2.Dockerfile
