#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Dockerfile with HEALTHCHECK instruction
content="
FROM busybox:latest\n
CMD [\"/etc/passwd\", \"/etc/hosts\"]\n
ENTRYPOINT [\"cat\"]\n
"

echo -en "" $content | sed 's/ //' > Dockerfile

