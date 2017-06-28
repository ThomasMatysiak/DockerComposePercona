FROM debian:jessie 

RUN echo "deb http://ftp.us.debian.org/debian/ jessie main non-free" >> /etc/apt/sources.list
RUN apt-get -y update && apt-get install -y wget apache2 libapache2-mod-fastcgi wordpress curl 

RUN chown -R www-data:www-data /var/www/html && chmod -R 775 /var/www/html

COPY 000-default.conf /etc/apache2/sites-available/010-custom.conf
# COPY wp.conf /etc/apache2/sites-available/wp.conf

# RUN a2ensite wp

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
RUN chmod +x /usr/local/bin/dumb-init

RUN \
	a2enmod proxy_fcgi && \
	rm -f /var/run/apache2/httpd.pid && \
	touch /var/log/apache2/error.log

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
