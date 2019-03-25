#!/bin/bash

docker run -it --rm -p 5000:5000 --name zip2000_node --network zip2000_network \
    zip2000_node

# Use this below to detach after starting
# docker run -it --rm -p 5000:5000 --name zip2000_node \
#     --network zip2000_network -d zip2000_node
