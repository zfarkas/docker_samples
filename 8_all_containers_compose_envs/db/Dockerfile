FROM mariadb

ARG MYSQL_DATABASE

COPY init_db.sql /docker-entrypoint-initdb.d

RUN sed -i.orig -e "s|zip2000_app|${MYSQL_DATABASE}|" /docker-entrypoint-initdb.d/init_db.sql
