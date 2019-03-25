# About

This directory contains two components: a Node.js component and a web component
(Apache + PHP). The web component gets some info from the Node.js component, and
displays it for the user.

# Usage

The `node` and `web` directories are built similarly to the [Create a simple
container](../0_simple_container) directory: there are scripts to build and
run the containers, additionally, the `node` directory contains scripts for
managing the network for this example.

The Node.js component's port `5000` is exposed to the same port on the host,
wherease the web component's internal port `80` is exposed to port `8080` on the
host.

First start the `node` component, and start the `web` component afterwards.

Once all the containers are running, open http://localhost:8080/ in your
browser. The first line is a counter returned by Node.js, the second line is
some message also coming from Node.js, but all these served through the web
component.
