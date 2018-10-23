#!/bin/sh

# Cleanup
rm -rf build/*sh || true
docker rm -f heirloom-sh-build || true
( cd heirloom-sh && git clean -df )
