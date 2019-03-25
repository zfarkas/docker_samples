# Build from a Node.js base from hub.docker.com
FROM node:lts

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

# Our app will listen on this port
EXPOSE 5000

# The command to start the application inside the container
CMD [ "npm", "start" ]
