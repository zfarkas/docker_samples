#!/bin/bash

# This script stops and removes running containers

[ $# -lt 1 ] && \
    echo "Please specifiy the containers IDs (or names) as arguments!" && \
    exit -1

for CONTAINER_ID in $*; do
    echo "Stopping container $CONTAINER_ID"
    docker stop $CONTAINER_ID
    echo "Removing container $CONTAINER_ID"
    docker rm $CONTAINER_ID
done
