#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

source VARS.sh

# Writing a Dockerfile with ARG instruction
content="
FROM nginx:alpine\n
LABEL maintainer=\"Collabnix\"\n
\n
VOLUME /$MOUNT\n
CMD [ \"nginx\",\"-g\",\"daemon off;\" ]\n
"

echo -en "" $content | sed 's/ //' > Dockerfile
