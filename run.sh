#!/bin/sh

docker run --rm -v `pwd`:/workspace centos:7 /bin/sh /workspace/scripts/build.sh
