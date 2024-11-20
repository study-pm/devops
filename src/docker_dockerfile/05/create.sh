#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

source VARS.sh

exec_form="
FROM alpine:3.5\n
LABEL maintainer=\"Collabnix\"\n
\n
ENTRYPOINT [\"/bin/echo\", \"Hi, your ENTRYPOINT instruction in Exec Form !\"]\n
"

echo -en "" $exec_form | sed 's/ //' > build1.Dockerfile

shell_form="
FROM alpine:3.5\n
LABEL maintainer=\"Collabnix\"\n
\n
ENTRYPOINT echo \"Hi, your ENTRYPOINT instruction in Shell Form !\"\n
"

echo -en "" $shell_form | sed 's/ //' > build2.Dockerfile
