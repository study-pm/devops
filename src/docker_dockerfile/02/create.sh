#!/bin/bash

source VARS.sh

content="
FROM alpine:3.5\n
RUN apk update\n
ADD $RES_URL .
"

echo -en "" $content | sed 's/ //' > $DOCKERFILE
