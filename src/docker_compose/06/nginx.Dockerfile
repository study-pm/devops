FROM nginx:alpine
RUN echo "nginx - Welcome to Docker Workshop!" >/usr/share/nginx/html/index.html
CMD ["nginx", "-g", "daemon off;"] ' > nginx/Dockerfile_nginx
