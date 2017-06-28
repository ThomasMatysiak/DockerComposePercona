FROM debian:wheezy

ENV PHP_VERSION 7.0.19

RUN apt-get update && \
        apt-get install -y wget \
        build-essential \
        nano \
        autoconf

RUN apt-get install -y libfcgi-dev \
        libfcgi0ldbl \
        libmcrypt-dev \
        libssl-dev \
        libc-client2007e \
        libc-client2007e-dev \
        libxml2-dev \
        libbz2-dev \
        libcurl4-openssl-dev \
        libjpeg-dev \
        libpng12-dev \
        libfreetype6-dev \
        libkrb5-dev \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev

RUN ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a

RUN \
        cd /tmp && \
        wget http://fr2.php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror -O php-src.tar.gz && \
        tar -zxvf php-src.tar.gz && \
        cd php-$PHP_VERSION && \
        ./configure \
            --prefix=/usr/local/php7 \
            --with-pdo-pgsql \
            --with-zlib-dir \
            --with-freetype-dir \
            --enable-mbstring \
            --with-libxml-dir=/usr \
            --enable-soap \
            --enable-calendar \
            --with-curl \
            --with-mcrypt \
            --with-zlib \
            --with-gd \
            --with-pgsql \
            --disable-rpath \
            --enable-inline-optimization \
            --with-bz2 \
            --with-zlib \
            --enable-sockets \
            --enable-sysvsem \
            --enable-sysvshm \
            --enable-pcntl \
            --enable-mbregex \
            --enable-exif \
            --enable-bcmath \
            --with-mhash \
            --enable-zip \
            --with-pcre-regex \
            --with-pdo-mysql \
            --with-mysqli \
            --with-jpeg-dir=/usr \
            --with-png-dir=/usr \
            --enable-gd-native-ttf \
            --with-openssl \
            --with-fpm-user=www-data \
            --with-fpm-group=www-data \
            --with-libdir=/lib/x86_64-linux-gnu \
            --enable-ftp \
            --with-imap \
            --with-imap-ssl \
            --with-kerberos \
            --with-gettext \
            --with-xmlrpc \
            --with-xsl \
            --enable-opcache \
            --enable-fpm && \
        make && \
        make install

COPY conf/php.ini /usr/local/php7/lib/php.ini
COPY conf/www.conf /usr/local/php7/etc/php-fpm.d/www.conf
COPY conf/php-fpm.conf /usr/local/php7/etc/php-fpm.conf
COPY conf/php7-fpm.init /etc/init.d/php7-fpm

RUN ln -s /usr/local/php7/sbin/php-fpm /usr/local/php7/sbin/php7-fpm
RUN chmod +x /etc/init.d/php7-fpm
RUN update-rc.d php7-fpm defaults

EXPOSE 9000

RUN /etc/init.d/php7-fpm check

CMD /etc/init.d/php7-fpm start
