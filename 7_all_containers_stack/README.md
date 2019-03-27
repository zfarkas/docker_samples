# About

This example is very similar to the
[Base containers in a stack](../4_base_containers_stack) example, but it
contains the components as shown in
[All three components containerized](../5_all_containers). Thus, the `node`
component doesn't maintain an internal counter, rather gets the information
from the database. This is shown in the [Usage](#usage) section.

# Usage

Please see the [Base containers in a stack](../4_base_containers_stack) example
for details.

The difference is when messages are published to the database, every `node`
container will serve the very same set of information through its `/messages`
endpoint:
```
$ curl -X POST -d "message=remek" http://192.168.68.23:8080/
...
$ # Just to see, we're really load balancing, check eth0 address values:
$ curl http://192.168.68.23:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth0":[{"address":"10.255.0.28","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:1c","internal":false,"cidr":"10.255.0.28/16"}],"eth2":[{"address":"172.22.0.7","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:16:00:07","internal":false,"cidr":"172.22.0.7/16"}],"eth1":[{"address":"10.0.2.11","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:02:0b","internal":false,"cidr":"10.0.2.11/24"}]}
$ curl http://192.168.68.23:5000/whoami
{"lo":[{"address":"127.0.0.1","netmask":"255.0.0.0","family":"IPv4","mac":"00:00:00:00:00:00","internal":true,"cidr":"127.0.0.1/8"}],"eth1":[{"address":"10.0.2.8","netmask":"255.255.255.0","family":"IPv4","mac":"02:42:0a:00:02:08","internal":false,"cidr":"10.0.2.8/24"}],"eth2":[{"address":"172.22.0.8","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:ac:16:00:08","internal":false,"cidr":"172.22.0.8/16"}],"eth0":[{"address":"10.255.0.25","netmask":"255.255.0.0","family":"IPv4","mac":"02:42:0a:ff:00:19","internal":false,"cidr":"10.255.0.25/16"}]}
$ #
$ # Now let's get messages from node containers
$ curl http://192.168.68.23:5000/messages
[{"id":1,"text":"remek","ts":"2019-03-27T10:42:29.000Z"}]
$ curl http://192.168.68.23:5000/messages
[{"id":1,"text":"remek","ts":"2019-03-27T10:42:29.000Z"}]
```
