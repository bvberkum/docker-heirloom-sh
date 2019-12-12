#!/bin/sh

# Add build on top of debian slim image
docker build --build-arg base_tag=9-slim -t heirloom-sh .

# Tag and publish image
docker tag heirloom-sh dotmpe/heirloom-sh:9-slim
docker push docker.io/dotmpe/heirloom-sh:9-slim

docker tag heirloom-sh dotmpe/heirloom-sh:latest
docker push docker.io/dotmpe/heirloom-sh:latest
