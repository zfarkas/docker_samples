# About

This example contains three components inside the software stack: a database,
a Node.js and a web component.

The three components implement a simple message wall application: the user
interface displays a list of the last 10 messages, and provides an input field
for adding new messages.

The `web` component uses the `node` component to query the last 10 messages,
whereas if users post new messages, the PHP code inserts the new message
directly into the database.

The `node` component provides the same endpoints as earlier, and also has a
`/messages` endpoint for querying the last 10 messages from the database (this
endpoint is invoked by `web`).

Finally, the `db` component has one single table (`messages`), containing an
ID field, a text field for the message text, and a timestamp field.

# Components' overview

## Database

The `db` component represents a MariaDB service, built on top of the
[official MariaDB image](https://hub.docker.com/_/mariadb) from the Docker Hub.
This image is prepared in a way which makes initialization the database very
simple: environment variables can be used to have database user accounts set up,
and database initialization is also possible through SQL scripts, or shell
scripts. Please see the description of this base image at the link above for
details.

## Node

The `node` component is the same as earlier, extended with a new endpoint for
querying the messages from the database.

** Note: ** there is an additional (`mysql`) dependency for the app.

## Web

This one should be straightforward. If the POST parameters contain a `message`
attribute, the message is stored in the database (using `mysqli`). Additionally,
the message list (using messages queried from `node`) and message form are
displayed.

# Usage

Start the `db`, `node` and `web` containers, access the web interface through
`http://localhost:8080/`.
