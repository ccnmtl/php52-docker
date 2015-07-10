# based on https://registry.hub.docker.com/u/former03/dev03-apache-php-5.2-squeeze/dockerfile/

FROM former03/dev03-apache-php-5.2-squeeze
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

# i don't think i need to do anything....
# RUN apt-get update

# Install FORMER 03 PHP 5.2
# RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends --fix-missing install former03-php-5-2
# RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install imagemagick

# Set default php
# RUN for i in /usr/former03/php/5.2/bin/*; do ln -s $i /usr/local/bin/$(basename $i)  ; done

# just copy in apache file
COPY ./files/ccnmtl-welty.conf /etc/apache2/sites-enabled/ccnmtl-welty.conf


