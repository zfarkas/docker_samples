#!/bin/bash

docker run -it --rm -p 8080:80 --name zip2000_web --network zip2000_network zip2000_web
