FROM debian:latest

# update the base image
RUN apt update
RUN apt install apt-utils -y
RUN apt upgrade -y

# install Apache HTTPD
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
RUN apt -y install ssl-cert apache2 apache2-utils
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers
RUN a2dissite 000-default

# Install ModSecurity v3 & OWASP ModSecurity Core Rule Set
RUN apt -y install libmodsecurity3 modsecurity-crs
RUN a2enmod security2
RUN cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
# Enable ModSecurity blocking rules
RUN sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine on/' /etc/modsecurity/modsecurity.conf

# Install PHP 7 Apache module
RUN apt -y install libapache2-mod-php
RUN echo '<?php phpinfo(); ?>' > /var/www/html/hidden.php

WORKDIR /

# cleanup some unwanted packages
RUN apt -y autoremove
RUN rm -rf /var/lib/apt/lists/*

CMD ["-X"]
ENTRYPOINT ["apache2"]
