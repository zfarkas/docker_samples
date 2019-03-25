# About

This example contains the containerization steps for a very simple Node.js
application.

The Node.js application is listening on `0.0.0.0:5000`, the only endpoint it
serves is `/`, and sends a `Hello world` as response.

# Usage

There are a number of shell scripts in this example, which help to get started
and try out the example easily and quickly:

- `01_build.sh`: can be used to build the Docker image. The image will be called
`zip2000_simple_container`
- `02_create_network.sh`: can be used to create a dedicated network for the
container. The network is called `simple_network`
- `03_run.sh`: can be used to start a container from the image build inside the
network
- `04_access_from_localhost.sh`: a set of cURL commands to check access to the
Node.js app running inside the container
- `04_access_from_container.sh`: a test to check access to the Node.js app from
an other container
- `05_remove_network.sh`: script to remove the network if not needed anymore.
