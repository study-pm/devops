FROM httpd:alpine
RUN echo "httpd - Welcome to Docker Workshop!" > /usr/local/apache2/htdocs/index.html
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"] ' > httpd/Dockerfile_httpd
