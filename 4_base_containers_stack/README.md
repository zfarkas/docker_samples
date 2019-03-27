# About

This example contains a two-layer application built using Docker stacks. It is
very similar to Compose (uses the very same YAML format with some differences),
but allows to scale the components (services) inside the stack easily.

# Usage

In order to create stacks, the Docker host must be in swarm mode. In this mode,
different Docker hosts (nodes) can build up a cluster for running scaled
services built from containers. Nodes in a swarm can be managers, workers, or
both. Manager nodes are accepting service definitions, and are responsible for
maintaining the health of this services (e.g. if one worker node running
containers of a scaled service goes down, managers rearrange the failed node's
containers to healthy worker nodes).

In order to initialize the Docker host as a swarm node (manager and worker) for
running stacks, execute the following command:
```
$ docker swarm init
Swarm initialized: current node (pdiscgmhhe5swjblaxr3c2ah3) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-22ddh9k17nsntzg1ipd4t4fezzw1swuf7xodiororgd9atifvj-cmm2r9nl9hg5zc6yndqnq6lnb 192.168.68.23:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```



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

**Note:** due to a [bug](https://github.com/docker/machine/issues/4608) in
Docker, services of the swarm with published ports will not be accessible
through `localhost`, but through the stack network's peer ID. This can be
queried as follows:
```
$ docker network inspect zip2000_stack_default
[
    {
        ...
        "Peers": [
            {
                "Name": "41dc27a476c4",
                "IP": "192.168.68.23"
            }
        ]
    }
]
```
Please use the value of `IP` to connect to the services' published ports.

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
$ curl http://192.168.68.23:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.7","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:07","internal":false,"cidr":"10.255.0.7/16"}],"eth2":[{"address":"172.21.0.4","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:04","internal":false,"cidr":"172.21.0.4/16"}],"eth1":[{"address":"10.0.0.6","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:06","internal":false,"cidr":"10.0.0.6/24"}]}
$ curl http://192.168.68.23:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.6","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:06","internal":false,"cidr":"10.255.0.6/16"}],"eth2":[{"address":"172.21.0.5","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:05","internal":false,"cidr":"172.21.0.5/16"}],"eth1":[{"address":"10.0.0.5","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:05","internal":false,"cidr":"10.0.0.5/24"}]}
$ curl http://192.168.68.23:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.4","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:04","internal":false,"cidr":"10.255.0.4/16"}],"eth2":[{"address":"172.21.0.3","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:03","internal":false,"cidr":"172.21.0.3/16"}],"eth1":[{"address":"10.0.0.3","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:03","internal":false,"cidr":"10.0.0.3/24"}]}
$ curl http://192.168.68.23:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.5","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:05","internal":false,"cidr":"10.255.0.5/16"}],"eth2":[{"address":"172.21.0.6","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:06","internal":false,"cidr":"172.21.0.6/16"}],"eth1":[{"address":"10.0.0.4","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:04","internal":false,"cidr":"10.0.0.4/24"}]}
$ curl http://192.168.68.23:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.7","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:07","internal":false,"cidr":"10.255.0.7/16"}],"eth2":[{"address":"172.21.0.4","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:15:00:04","internal":false,"cidr":"172.21.0.4/16"}],"eth1":[{"address":"10.0.0.6","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:00:06","internal":false,"cidr":"10.0.0.6/24"}]}
```
As it can be seen, the IP address of the different interfaces changes, as the
requests are sent out to the different containers behind the service.

We can also access the `web` component, to see how the internal counters of the
different `node` containers is maintained locally:
```
$ curl http://192.168.68.23:8080/
Data received from node: 0
<br/>And this is the message from node: Hello world
$ curl http://192.168.68.23:8080/
Data received from node: 0
<br/>And this is the message from node: Hello world
$ curl http://192.168.68.23:8080/
Data received from node: 0
<br/>And this is the message from node: Hello world
$ curl http://192.168.68.23:8080/
Data received from node: 0
<br/>And this is the message from node: Hello world
$ curl http://192.168.68.23:8080/
Data received from node: 1
<br/>And this is the message from node: Hello world
$ curl http://192.168.68.23:8080/
Data received from node: 1
<br/>And this is the message from node: Hello world
$ curl http://192.168.68.23:8080/
Data received from node: 1
<br/>And this is the message from node: Hello world
```

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

In order to stop and remove the stack, please execute:
```
$ docker stack rm zip2000_stack
```


# Notes

- It might happen that ports to be published are not accessible. In this case
either the Docker service on the host must be restarted (know bug, see above),
or one has to inspect the stack's network
(`docker network inspect <network-name>`), and connect to the network peer's
IP address.

- Stacks, as opposed to Compose, cannot build images, so the YAML file must
reference an image available locally or downloadable from the image registry.

- After a stack is removed (`docker stack rm <stack>`), the containers should be
stopped and removed. For some reason some containers are not removed, you can
find them with `docker ps -a`, and remove with `docker rm <container_id>`.
