#!/bin/sh
docker run -i -w /src/project \
    -v $(realpath .):/src/project \
    dotmpe/redo:gcc-8-dev redo all
