#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Dockerfile with HEALTHCHECK instruction
content="
FROM nginx:1.13\n
HEALTHCHECK --interval=30s --timeout=3s \ \n
\tCMD curl -f http://localhost/ || exit 1\n
EXPOSE 80\n
"

echo -en "" $content | sed 's/ //' > Dockerfile

