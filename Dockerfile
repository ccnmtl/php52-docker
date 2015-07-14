# based on https://registry.hub.docker.com/u/former03/dev03-apache-php-5.2-squeeze/dockerfile/

FROM former03/dev03-apache-php-5.2-squeeze
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

# just copy in apache file
COPY ./files/ccnmtl-welty.conf /etc/apache2/sites-enabled/ccnmtl-welty.conf


