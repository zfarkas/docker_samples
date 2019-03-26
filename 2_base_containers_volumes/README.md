# About

This example has the very same apps as the [Base (Node.js and web)
containers](../1_base_containers) example, but the `web` component uses a volume
to share files between the host and the container. This demonstrates the
efficient way to run containers during the development phase - once the `web`
component's container is running, it is not necessary to rebuild the image if
the PHP code changes, the changes are propagated to the running container
through the volume.

# Usage

 See [Base (Node.js and web) containers](../1_base_containers).
