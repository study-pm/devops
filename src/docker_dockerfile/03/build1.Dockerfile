FROM nginx:alpine
LABEL maintainer="Collabnix"

COPY index.html /usr/share/nginx/html/
ENTRYPOINT ["nginx", "-g", "daemon off;"]
