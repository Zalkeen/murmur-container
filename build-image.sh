#!/bin/bash

version=$(grep "ENV VERSION .*" Dockerfile \
  | awk 'NF>1 {print $NF}' \
  | awk -F '-' '{print $1}')
arch=$(uname -m)
tag="$version"

case "$arch" in
  armv*   ) arch="armhf" ;;
  aarch64 ) arch="arm64" ;;
  *       ) arch=""      ;;
esac

if [ ! -z "$arch" ]; then
  tag+="-$arch"
fi

docker build -t zalkeen/murmur:${arch:-latest} .
docker build -t zalkeen/murmur:$tag .

