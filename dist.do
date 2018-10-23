#!/bin/sh

# Add build on top of debian slim image
docker build --build-arg base_tag=9-slim -t heirloom-sh .

# Tag and publish image
docker tag heirloom-sh bvberkum/heirloom-sh:9-slim
docker push docker.io/bvberkum/heirloom-sh:9-slim

docker tag heirloom-sh bvberkum/heirloom-sh:latest
docker push docker.io/bvberkum/heirloom-sh:latest
