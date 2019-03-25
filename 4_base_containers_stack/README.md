# About

This example contains a two-layer application built using Docker Stacks. It is
very similar to Compose (uses the very same YAML format with some differences),
but allows to scale the components (services) inside the stack easily.

# Usage

## Start the stack

To bring up a stack containing the node and the web components, please run this
command (`zip2000_stack` will be stack's name):
```
$ docker stack deploy -c docker-compose.yml zip2000_stack
Creating network zip2000_stack_default
Creating service zip2000_stack_zip2000_node
Creating service zip2000_stack_zip2000_web
```
This will bring up a new network for the stack, and start the containers as
described in the YAML file `docker-compose.yml`.


## Check and access services of a stack

One can check the services associated with the stack:
```
$ docker service ls
ID                  NAME                         MODE                REPLICAS            IMAGE                 PORTS
117aobufio9h        zip2000_stack_zip2000_node   replicated          4/4                 zip2000_node:latest   *:5000->5000/tcp
mb1ymxa8muof        zip2000_stack_zip2000_web    replicated          1/1                 zip2000_web:latest    *:8080->80/tcp
```

As it can be seen, the `zip2000_node` service has four replicas. When invoking
the service through its published port (`5000`), Docker will load balance
between the containers belonging to the given service. The `node` component has
a `/whoami` endpoint, which returns the network configuration for the host.
Let's perform a few calls to this endpoint:
```
$ curl http://localhost:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.7","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:07","internal":false,"cidr":"10.255.0.7/16"}],"eth2":[{"address":"172.21.0.4","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:04","internal":false,"cidr":"172.21.0.4/16"}],"eth1":[{"address":"10.0.0.6","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:06","internal":false,"cidr":"10.0.0.6/24"}]}
$ curl http://localhost:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.6","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:06","internal":false,"cidr":"10.255.0.6/16"}],"eth2":[{"address":"172.21.0.5","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:05","internal":false,"cidr":"172.21.0.5/16"}],"eth1":[{"address":"10.0.0.5","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:05","internal":false,"cidr":"10.0.0.5/24"}]}
$ curl http://localhost:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.4","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:04","internal":false,"cidr":"10.255.0.4/16"}],"eth2":[{"address":"172.21.0.3","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:03","internal":false,"cidr":"172.21.0.3/16"}],"eth1":[{"address":"10.0.0.3","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:03","internal":false,"cidr":"10.0.0.3/24"}]}
$ curl http://localhost:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.5","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:05","internal":false,"cidr":"10.255.0.5/16"}],"eth2":[{"address":"172.21.0.6","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:06","internal":false,"cidr":"172.21.0.6/16"}],"eth1":[{"address":"10.0.0.4","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:04","internal":false,"cidr":"10.0.0.4/24"}]}
$ curl http://localhost:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.7","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:07","internal":false,"cidr":"10.255.0.7/16"}],"eth2":[{"address":"172.21.0.4","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:04","internal":false,"cidr":"172.21.0.4/16"}],"eth1":[{"address":"10.0.0.6","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:06","internal":false,"cidr":"10.0.0.6/24"}]}
```
As it can be seen, the IP address of the different interfaces changes, as the
requests are sent out to the different containers behind the service.


## Scale a service

It is possible to scale up or down a service. There are multiple options for
this:

1. Update the value of the `replicas` key in the `docker-compose.yml` file to
the desired value, and execute this command:
```
$ docker stack deploy -c docker-compose.yml zip2000_stack
```

2. Scale using the `docker service scale`:
```$ docker service scale zip2000_stack_zip2000_node=2
zip2000_stack_zip2000_node scaled to 2
overall progress: 2 out of 2 tasks
1/2: running   [==================================================>]
2/2: running   [==================================================>]
verify: Service converged
```


## Stop the stack

In order to stop the stack, please execute:
```
$ docker stack rm zip2000_stack
```


# Notes

- It might happen that ports to be published are not published. In this case
either the Docker service on the host must be restarted (know bug), or one has
to inspect the stack's network (`docker network inspect <network-name>`), and
connect to the netowk peer's IP address.

- Stacks, as opposed to Compose, cannot build images, so the YAML file must
reference an image available locally or fetchable from the image registry.
