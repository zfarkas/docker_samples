# Use this image from the docker hub. Offers a base containing apache configured
# for hosting PHP applications
FROM php:7.3-apache

# Update packages
RUN apt-get update

# Install dependency for php-curl extension
RUN apt-get install -y libcurl3-dev

# Install and enable php-curl extension
RUN docker-php-ext-install curl

# And mysqli as well
RUN docker-php-ext-install mysqli

# Copy the content of src under /var/www/html in the image
COPY src/ /var/www/html


# Note: EXPOSE and CMD are not used here, as they are already defined for the
# base image. The relevant Dockerfile at https://hub.docker.com/_/php can be
# checked for details, port 80 is used in this case.
