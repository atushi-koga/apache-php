FROM centos:7.4.1708

RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

RUN yum install -y vim

RUN yum -y install httpd
RUN usermod -u 1000 apache \
    && groupmod -g 1000 apache
COPY httpd.conf /etc/httpd/conf/httpd.conf

RUN yum -y install --enablerepo=remi,remi-php72 php php-cli php-common　php-fedora-autoloader php-fpm php-gd php-json php-mbstring php-mcrypt php-opcache php-pdo php-pear php-pecl-zip php-pgsql php-process php-xml
RUN yum -y install zip unzip
RUN ["touch", "/var/log/php.log"]
RUN ["chmod", "a+w", "/var/log/php.log"]
COPY php.ini /etc/php.ini

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum -y install nodejs

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

WORKDIR /var/www/html
EXPOSE 80
EXPOSE 8080