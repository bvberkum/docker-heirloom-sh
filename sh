#!/bin/sh
set -e

heirloom_git=github.com/grml/heirloom-sh

# XXX: alpine heirloom-sh build simply says 'no space'
#builder_image=comodal/alpine-gcc-make

builder_image=gcc

# Init
test -d heirloom-sh || {
  test -e /src/$heirloom_git && {
    ln -s /src/$heirloom_git
  } || {
    git clone http://$heirloom_git
  }
}

# Cleanup
rm -rf build/* || true
docker rm -f heirloom-sh-build || true
( cd heirloom-sh && git clean -df )

# Build & check
docker run -ti \
  --name heirloom-sh-build \
  -v $(realpath ./heirloom-sh):/src/heirloom-sh \
  $builder_image \
  sh -c 'cd /src/heirloom-sh && make -f makefile && ./sh -c "echo foo"'

# Gather
mkdir -p build
docker cp heirloom-sh-build:/src/heirloom-sh/jsh ./build/
docker cp heirloom-sh-build:/src/heirloom-sh/sh ./build/

# Result is jsh symlink to sh, and sh
ls -la build/

# Add build on top of debian slim image
docker build --build-arg base_tag=9-slim -t heirloom-sh .

# Tag and publish image
docker tag heirloom-sh bvberkum/heirloom-sh:9-slim
docker push docker.io/bvberkum/heirloom-sh:9-slim

docker tag heirloom-sh bvberkum/heirloom-sh:latest
docker push docker.io/bvberkum/heirloom-sh:latest
