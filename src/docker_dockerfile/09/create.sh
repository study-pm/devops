#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

source VARS.sh

# Writing a Dockerfile with ENV instruction
content="
FROM alpine:3.9.3\n
LABEL maintainer=\"Collabnix\"\n
\n
ENV WELCOME_MESSAGE=\"Welcome to Docker World\"\n
\n
CMD [\"sh\", \"-c\", \"echo \$WELCOME_MESSAGE\"]\n
"

echo -en "" $content | sed 's/ //' > Dockerfile
