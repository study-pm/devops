#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

source VARS.sh

# Writing a Dockerfile with ARG instruction
content="
FROM alpine:3.9.3\n
LABEL maintainer=\"Collabnix\"\n
\n
#Setting a default value to Argument WELCOME_USER\n
ARG WELCOME_USER=Collabnix\n
RUN echo \"Welcome \$WELCOME_USER, to Docker World!\" > message.txt\n
CMD cat message.txt\n
"

echo -en "" $content | sed 's/ //' > Dockerfile
