#!/bin/bash

set -e

IMAGE_NAME="zalkeen/murmur"

operation="$1"

version=$(grep "ENV VERSION .*" Dockerfile \
  | awk 'NF>1 {print $NF}' \
  | awk -F '-' '{print $1}')
arch="${2:-$(uname -m)}"
tag="$version"

case "$arch" in
  armv*   | armhf ) arch="armhf" ;;
  aarch64 | arm64 ) arch="arm64" ;;
  *               ) arch=""      ;;
esac

if [ ! -z "$arch" ]; then
  tag+="-$arch"
fi

image_name_latest="$IMAGE_NAME:${arch:-latest}"
image_name_version="$IMAGE_NAME:$tag"

case "$operation" in

  build )
    docker build -t "$image_name_latest" .
    docker build -t "$image_name_version" .
    echo "Built $image_name_latest"
    echo "Built $image_name_version"
  ;;

  push )
    docker push "$image_name_latest"
    docker push "$image_name_version"
    echo "Pushed $image_name_latest"
    echo "Pushed $image_name_version"
  ;;

esac
