#!/bin/bash

# The base image for the container provides initialization possibilities, like
# settings users and passwords. We can pass this information through environment
# variables to the container.

docker run -it --rm -p 3306:3306 --name zip2000_db --network zip2000_network \
    -e "MYSQL_ROOT_PASSWORD=pass" \
    -e "MYSQL_DATABASE=zip2000_app" \
    -e "MYSQL_USER=zip2000_user" \
    -e "MYSQL_PASSWORD=zip2000_pass" \
    zip2000_db

# Use this below to detach after starting
# docker run -it --rm -p 3306:3306 --name zip2000_db \
#     --network zip2000_network -d zip2000_db
