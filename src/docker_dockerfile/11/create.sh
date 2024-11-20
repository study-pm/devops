#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Dockerfile with EXPOSE instruction
content="
FROM nginx:alpine\n
LABEL maintainer=\"Collabnix\"\n
\n
EXPOSE 80/tcp\n
EXPOSE 80/udp\n
\n
CMD [ \"nginx\",\"-g\",\"daemon off;\" ]\n
"

echo -en "" $content | sed 's/ //' > Dockerfile
