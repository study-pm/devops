#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Dockerfile
content="
FROM nginx:alpine\n
RUN echo \"Welcome to Docker Workshop!\" >/usr/share/nginx/html/index.html\n
CMD [\"nginx\", \"-g\", \"daemon off;\"]\n
"

echo -en "" $content | sed 's/ //' > Dockerfile

