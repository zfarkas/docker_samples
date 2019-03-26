FROM mariadb

# Let's copy our initialization script into the location below - this will
# create the table necessary for storing messages in the database.
COPY init_db.sql /docker-entrypoint-initdb.d
