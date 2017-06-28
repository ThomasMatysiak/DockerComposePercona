FROM debian:wheezy


RUN \
        echo 'deb http://deb.debian.org/debian jessie main non-free' > /etc/apt/sources.list && \
        apt-get update -y && \
        apt-get install -y --no-install-recommends apache2 libapache2-mod-fastcgi 

RUN chown -R www-data:www-data /var/www/html && chmod -R 775 /var/www/html

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN \
	a2enmod proxy_fcgi && \
	rm -f /var/run/apache2/httpd.pid && \
	touch /var/log/apache2/error.log

EXPOSE 80
EXPOSE 443

CMD /usr/sbin/apache2ctl -D FOREGROUND
