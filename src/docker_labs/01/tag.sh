#!/bin/bash

source VARS.sh

docker tag $IMG_NAME "$IMG_TAG:$IMG_VERSION"
