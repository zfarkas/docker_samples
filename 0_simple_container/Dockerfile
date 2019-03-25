# Define our base image
FROM ubuntu:latest

# Install some packages
RUN apt-get update
RUN apt-get install -y curl

# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Set working directory for subsequent commands
WORKDIR /myapp

# Copy host's current directory's content to /myapp
COPY . /myapp

# Install necessary packages
RUN npm install

# Define the command to start the container
CMD npm start
