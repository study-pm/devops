#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

source VARS.sh

content="
FROM alpine:3.6\n
\n
RUN apk update\n
CMD [\"top\"]\n
"

echo -en "" $content | sed 's/ //' > $DOCKERFILE
