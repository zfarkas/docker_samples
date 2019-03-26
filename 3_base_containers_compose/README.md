# About

This example contains a two-layer application built with Docker Compose. The big
advantage of Compose when compared to setting up components individually is that
instead of starting multiple containers one after the other, a single command
can be used to bring up a complex architecture. One simple YAML file can be used
to set up all the properties of the individual containers.

# Usage

To bring up the architecture containing the node and the web components, please
run this command:
```
$ docker-compose up --build
```

This will start the containers as described in the YAML file
`docker-compose.yml`, and you'll be able to see their output as well.

In order to detach, please execute:
```
$ docker-compose up --build --detach
```

Once finished, you can use `CTRL+c` to stop the containers. Finally, to clean up
(and the stop everything in detached mode) execute the following command:
```
$ docker-compose down
```

# Notes

- Docker Compose allows to scale a container. In this case, please take care that
the scaled container's hostname cannot be specified in the `docker-compose.yml`
file, thus other components won't be able to access the instances of the given
component. In this case additional components must be added to the architecture,
as described in [this Medium.com article](https://medium.com/@benoittellier3/automatic-load-balancing-for-your-docker-compose-services-aa6b96f20d20).

- Docker Compose automatically creates a network for the containers if no network
is specified in `docker-compose.yml`.
