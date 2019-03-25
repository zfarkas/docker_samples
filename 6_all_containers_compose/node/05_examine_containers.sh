#!/bin/bash

# This script checks the running containers

docker ps


# It is possible to filter containers, e.g. we query only those exposing port
# 5000 (i.e. sample_app_node containers).

# docker ps --filter "expose=5000"
