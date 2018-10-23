#!/bin/sh
docker run -i -w /src/project \
    -v $(realpath .):/src/project \
    bvberkum/redo:gcc-8-dev redo all
