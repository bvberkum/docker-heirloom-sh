#!/bin/sh

redo-ifchange init

( cd ./heirloom-sh/ && make -f makefile )

## Gather, result is jsh symlink to sh, and sh
mkdir -p build
cp ./heirloom-sh/jsh ./build/
cp ./heirloom-sh/sh ./build/
