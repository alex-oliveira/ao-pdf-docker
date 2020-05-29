FROM alpine:3.8

MAINTAINER Alex Oliveira <bsi.alexoliveira@gmail.com>

USER root

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

#
# INSTALATIONS
#
RUN echo "alias ll='ls -alF'" >> /root/.bashrc \
 && echo "alias www='cd /var/www'" >> /root/.bashrc \
 && echo "alias routes='php artisan route:list'" >> /root/.bashrc \
 && echo "alias tinker='php artisan tinker'" >> /root/.bashrc \
 #
 # UPDATE PACKAGES
 #
 && apk update \
 #
 # INSTALL UTILITIES
 #
 && apk add \
    bash wget curl tzdata nginx openssl pdftk \
 #
 # INSTALL PHP
 #
 && apk add \
    php7 php7-opcache php7-fpm php7-cgi php7-ctype php7-json php7-dom php7-zip php7-gd php7-curl php7-mbstring \
    php7-redis php7-mcrypt php7-iconv php7-posix php7-pdo_mysql php7-tokenizer php7-simplexml php7-session \
    php7-xml php7-sockets php7-openssl php7-fileinfo php7-ldap php7-exif php7-pcntl php7-xmlwriter php7-phar \
    php7-zlib php7-intl \
 #
 # INSTALL COMPOSER
 #
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
 #
 # CLEAN CACHE
 #
 && rm -rf /var/cache/apk/*

#
# CONFIGS
#
COPY ./configs/start.sh /home/start.sh
#COPY ./configs/php.ini /etc/php7/php.ini
COPY ./configs/nginx.conf /etc/nginx/nginx.conf
COPY ./configs/default.conf /etc/nginx/conf.d/default.conf
COPY ./api /var/www

RUN rm -rf /tmp/* /var/tmp/* /usr/share/doc/* /var/www/* \
 && adduser -D -g 'www' www \
 && mkdir -p /var/tmp/nginx \
 && mkdir -p /var/run/nginx \
 && chown -R www:www /var/lib/nginx \
 && chown -R www:www /var/run/nginx \
 && chown -R www:www /var/tmp/nginx \
 && chown -R www:www /var/log/nginx \
 && chown -R www:www /var/log/nginx \
 && chown -R www:www /var/www \
 && chown -R www:www /home/start.sh \
 && chmod +x /home/start.sh

#USER www

WORKDIR /var/www

RUN echo ":)" >> /var/www/index.html

EXPOSE 80

ENTRYPOINT ["/bin/bash"]

#STOPSIGNAL SIGTERM
#CMD ["nginx", "-g", "daemon off;"]
#CMD ["/home/start.sh"]