#!/bin/bash

# This script accesses the node continer through its published port.

# Note: the '-p' switch for 'docker run' is mandatory for this type of access
# to work.

curl http://localhost:5000/
