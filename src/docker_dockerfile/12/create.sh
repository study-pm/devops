#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Dockerfile with LABEL instruction
content="
FROM alpine:3.5\n
RUN echo \"Hello Docker\"\n
\n
LABEL name=\"learning-docker\"\n
LABEL email=\"[email protected]\"\n
LABEL \"com.example.vendor\"=\"ACME Incorporated\"\n
LABEL com.example.label-with-value=\"foo\"\n
LABEL version=\"1.0\"\n
LABEL description=\"This text illustrates\\ \n
that label-values can span multiple lines.\"\n
"

echo -en "" $content | sed 's/ //' > Dockerfile
