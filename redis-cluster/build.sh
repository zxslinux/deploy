#!/bin/bash
#
set -xe
PROJECT_ROOT=`cd $(dirname $0);pwd`
VERSION=$1

# download redis src package
VERSION=${VERSION:-"stable"}
wget http://download.redis.io/releases/redis-${VERSION}.tar.gz

# complie redis
tar xvf redis-${VERSION}.tar.gz
cd ${PROJECT_ROOT}/redis-${VERSION}
make

# copy binary file
cp -a src/{redis-sentinel,redis-benchmark,redis-server,redis-trib.rb,mkreleasehdr.sh,redis-check-aof,redis-check-rdb,redis-cli} ${PROJECT_ROOT}/playbook/roles/redis-cluster/files/

# clean redis src dir
rm -rf ${PROJECT_ROOT}/redis-${VERSION}*