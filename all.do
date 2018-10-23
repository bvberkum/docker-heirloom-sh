#!/bin/sh
redo-ifchange init
redo clean
redo-ifchange make
#redo-ifchange dist
