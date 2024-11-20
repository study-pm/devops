#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles and index file

source VARS.sh

v1="
FROM nginx:alpine\n
LABEL maintainer=\"Collabnix\"\n
\n
COPY index.html /usr/share/nginx/html/\n
ENTRYPOINT [\"nginx\", \"-g\", \"daemon off;\"]\n
"

echo -en "" $v1 | sed 's/ //' > build1.Dockerfile

echo "Welcome to Dockerlabs !" > index.html

v2="
FROM alpine AS stage1\n
LABEL maintainer=\"Collabnix\"\n
RUN echo \"Welcome to Docker Labs!\" > /opt/index.html\n
\n
FROM nginx:alpine\n
LABEL maintainer=\"Collabnix\"\n
COPY --from=stage1 /opt/index.html /usr/share/nginx/html/\n
ENTRYPOINT [\"nginx\", \"-g\", \"daemon off;\"]\n
"

echo -en "" $v2 | sed 's/ //' > build2.Dockerfile
