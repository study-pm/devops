FROM alpine:3.9.3
LABEL maintainer="Collabnix"
RUN apk add --update && \
	apk add curl && \
	rm -rf /var/cache/apk/
