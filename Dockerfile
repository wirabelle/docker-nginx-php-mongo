FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y nano supervisor nginx git mongodb php7.2-fpm php-mongodb 

# nginx
COPY ./etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default 

# php-fpm
RUN mkdir -p /var/run/php

# mongodb
RUN mkdir -p /data/db

# supervisor
COPY ./etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]


# Define working directory.
WORKDIR /var/www

# Define default command.
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Expose ports.
EXPOSE 80
EXPOSE 443 