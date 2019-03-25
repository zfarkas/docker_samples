#!/bin/bash

# This script is used to build the image for application.
# The '-t <name>[:<tag>]' switch can be used to give a name and tag for the
# image, 'latest' tag is used to indicate as the latest version of the image,
# which will be used to start containers unless <tag> is specified with
# 'docker run'.

docker build -t zip2000_simple_container .
