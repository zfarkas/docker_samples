#!/bin/bash

# This script demonstrates how to access the service of a container from an
# other container. The two containers attach to the same network, thus are able
# to access each other by using container names.

# Here we're using the 'alpine-curl' image from the Docker Hub. This image
# offers a minimal (few MBs) image with cURL inside. Arguments after the image
# name are passed onto the curl command inside the container. This, we're
# simply accessing the / endpoint of the node conainer.

# Note: when we started the container zip2000_simple_container, we published
# its ports with the '-p' switch. If we will be accessing exposed ports of the
# container only from other containers inside the same network, then the '-p'
# switch can be omitted.


docker run -it --rm --network simple_network byrnedo/alpine-curl http://zip2000_simple_container:5000/
