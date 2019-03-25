#!/bin/bash

# This script is used to create a network for running containers. Docker offers
# a default bridge network by default, but containers attached to this cannot
# access each other using their names, only by using their IPs. If we create a
# network, containers will be able to use container names to access each other.

docker network create simple_network
