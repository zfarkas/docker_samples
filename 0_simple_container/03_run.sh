#!/bin/bash

# This script can be used to start a container based on images built previously,
# or from a registry. Port 5000 of the container (where the node app is
# listening) is exposed to the host's port 5000
# (-p <host_port>:<container_port>).

# Other interesting options for 'docker run':
# -d: run in background (detach)
# --name <name>: set the name for the container (otherwise generated)
# -e <NAME>=<value>: set environment variables
# --rm: remove the container when it finished
# --network <name>: attach to a network
#
# See 'docker run --help' for others

docker run -it --rm -p 5000:5000 --name zip2000_simple_container \
    --network simple_network zip2000_simple_container

# Use this below to detach after starting
# docker run -it --rm -p 5000:5000 --name zip2000_simple_container \
#     --network simple_network -d zip2000_simple_container
