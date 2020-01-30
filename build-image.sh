#!/bin/bash

version=$(grep "ENV VERSION .*" Dockerfile | awk 'NF>1{print $NF}')
arch=$(uname -m)
tag="$version"

case "$arch" in
  "armv*"   ) tag+="-armhf" ;;
  "aarch64" ) tag+="-arm64" ;;
esac

docker build -t zalkeen/murmur:$tag .

