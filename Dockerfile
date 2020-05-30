FROM alpine:3.8

MAINTAINER Alex Oliveira <bsi.alexoliveira@gmail.com>

USER root

COPY etc /etc
COPY scripts /scripts
COPY www /www

#
# INSTALATIONS
#
RUN echo "alias ll='ls -alF'" >> /root/.bashrc \
 && echo "alias www='cd /www'" >> /root/.bashrc \
 && echo "alias routes='php artisan route:list'" >> /root/.bashrc \
 && echo "alias tinker='php artisan tinker'" >> /root/.bashrc \
 #
 # INSTALL UTILITIES
 #
 && apk add --update \
    bash wget curl tzdata nginx openssl pdftk openssh fontconfig libxrender libxext imagemagick unzip make sudo \
 #
 # INSTALL PHP
 #
 && apk add --update \
    php7 php7-fpm php7-cgi php7-phar php7-curl php7-apcu php7-bcmath \
    php7-opcache php7-redis php7-memcached php7-ctype php7-gd php7-mbstring php7-mcrypt php7-openssl \
    php7-mysqli php7-mysqlnd php7-pdo_mysql php7-pdo_pgsql php7-pgsql php7-mongodb php7-sqlite3 php7-pdo_sqlite \
    php7-json php7-dom php7-soap php7-xml php7-xmlwriter php7-xmlreader php7-simplexml \
    php7-zip php7-bz2 php7-xsl php7-fileinfo php7-exif php7-gmp php7-imagick php7-imap \
    php7-zlib php7-iconv php7-posix php7-tokenizer php7-session php7-sockets php7-ldap php7-pcntl php7-intl \
    php7-xdebug php7-phpdbg php7-sodium php7-mailparse php7-calendar \
 #
 # CONFIG PHP
 #
 && ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm \
 #
 # INSTALL COMPOSER
 #
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
 #
 # CLEAN
 #
 && rm -rf /tmp/* /var/cache/apk/* /var/tmp/* /usr/share/doc/* /var/www/* \
 #
 # CONFIG NGINX
 #
 && adduser -D -g 'www' www \
 && mkdir -p /var/run/nginx \
 && mkdir -p /var/tmp/nginx \
 && chown -R www:www /var/lib/nginx \
 && chown -R www:www /var/log/nginx \
 && chown -R www:www /var/log/nginx \
 && chown -R www:www /var/run/nginx \
 && chown -R www:www /var/tmp/nginx \
 && chown -R www:www /www \
 && chown -R www:www /scripts \
 && chmod +x /scripts/start.sh

#USER www

WORKDIR /www

EXPOSE 8080

ENV PATH=/scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENTRYPOINT ["/bin/bash"]

CMD ["/scripts/start.sh"]