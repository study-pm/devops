#!/bin/bash

echo -e "FROM alpine:3.5\nRUN apk update\nRUN apk add git" > Dockerfile
