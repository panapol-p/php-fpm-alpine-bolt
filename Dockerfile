FROM php:7.3-fpm-alpine

# install what u need
RUN apk --no-cache add nginx supervisor curl
RUN apk add bash
RUN apk add nano

# install and enable php extension for phpBolt
COPY config_docker/bolt.so /usr/local/etc/php/ext/bolt.so
RUN echo "extension='/usr/local/etc/php/ext/bolt.so'" >> /usr/local/etc/php/conf.d/docker-php-ext-bolt.ini

# install what u need
RUN docker-php-ext-install pdo pdo_mysql
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

# restart php-fpm service for reload php config
RUN kill -USR2 1