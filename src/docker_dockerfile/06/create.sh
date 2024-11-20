#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

source VARS.sh

# Dockerfile with WORKDIR instruction
v1="
FROM alpine:3.9.3\n
LABEL maintainer=\"Collabnix\"\n
\n
WORKDIR /opt\n
"

echo -en "" $v1 | sed 's/ //' > build1.Dockerfile

# WORKDIR with relative path
v2="
FROM alpine:3.9.3\n
LABEL maintainer=\"Collabnix\"\n
\n
WORKDIR /opt\n
RUN echo \"Welcome to Docker Labs\" > opt.txt\n
WORKDIR folder1\n
RUN echo \"Welcome to Docker Labs\" > folder1.txt\n
WORKDIR folder2\n
RUN echo \"Welcome to Docker Labs\" > folder2.txt\n
"

echo -en "" $v2 | sed 's/ //' > build2.Dockerfile

# WORKDIR with Absolute path
v3="
FROM alpine:3.9.3\n
LABEL maintainer=\"Collabnix\"\n
\n
WORKDIR /opt/folder1\n
RUN echo \"Welcome to Docker Labs\" > opt.txt\n
WORKDIR /var/tmp/\n
"

echo -en "" $v3 | sed 's/ //' > build3.Dockerfile

# WORKDIR with environment variables as path
v4="
FROM alpine:3.9.3\n
LABEL maintainer=\"Collabnix\"\n
\n
ENV DIRPATH=\"/myfolder\"\n
WORKDIR \$DIRPATH\n
"

echo -en "" $v4 | sed 's/ //' > build4.Dockerfile
