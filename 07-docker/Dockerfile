FROM debian:bullseye

RUN apt-get update && apt-get install -y curl apache2 php mc
ADD ./index.php /var/www/html/index.php
RUN rm /var/www/html/index.html
EXPOSE 80
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]