# About

This example is slightly modified version of the [Compose for all
containers](6_all_containers_compose) example. In this case, some variables are
defined in a `.env` file. The values defined here are picked up during the build
process of the images, and also during the execution of the containers. One can
modify the name of the MySQL database, the username, password or the port where
the `node` component should listen.

# Usage

As the `docker-compose.yml` file contains the build keywords, there is no need
for the different `.sh` scripts in the components' directories, thus they've
been removed.

First, check the `.env` file for the variables, and modify as necessary:
```
$ cat .env
MYSQL_ROOT_PASSWORD=pass
MYSQL_DATABASE=zip2000_db
MYSQL_USER=zip2000_user
MYSQL_PASSWORD=zip2000_pass

NODE_PORT=5000
```

Next, the components can be started:
```
$ docker-compose up --build
```

This will build all the images, and start the necessary containers based on
them.

The different components read the values from environment variables. For
example, the `node` component has the following environment variables defined
in `docker-compose.yml`:
```
...
        environment:
            MYSQL_DATABASE: ${MYSQL_DATABASE}
            MYSQL_USER: ${MYSQL_USER}
            MYSQL_PASSWORD: ${MYSQL_PASSWORD}
            NODE_PORT: ${NODE_PORT}
        ...
```
All the above variables are defined in the `.env` file. The Node.js application
uses the following code to get the environment variables:
```
...
const PORT = process.env.NODE_PORT;
const HOST = '0.0.0.0';

const MYSQL_HOST = 'zip2000_db';
const MYSQL_USER = process.env.MYSQL_USER;
const MYSQL_PASS = process.env.MYSQL_PASSWORD;
const MYSQL_DB   = process.env.MYSQL_DATABASE;
...
```


Please see the [Docker compose and base
containers](../3_base_containers_compose) example for additional details on
managing containers with compose.
