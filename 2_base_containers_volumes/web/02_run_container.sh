#!/bin/bash

# In the 'docker run' command below, we're attaching the 'src' directory's
# content under the '/var/www/html' directory inside the container. This
# enables us to modify the PHP code while the container is running, so
# development becomes an easy task.

docker run -it --rm -p 8080:80 --name zip2000_web --network zip2000_network \
    -v $PWD/src:/var/www/html zip2000_web
