#!/bin/bash

if [ ! -f /etc/network/if-up.d/custom-network-config ]; then

  # Install apache
  /usr/bin/apt-get -y install apache2
  cat > /var/www/index.html <<EOD
<html><head><title>${HOSTNAME}</title></head><body><h1>${HOSTNAME} on Apache</h1>
<p>This is the default web page for ${HOSTNAME} on Apache.</p>
</body></html>
EOD

  # Log the X-Forwarded-For
  perl -pi -e  's/^LogFormat "\%h (.* combined)$/LogFormat "%h %{X-Forwarded-For}i $1/' /etc/apache2/apache2.conf
  /usr/sbin/service apache2 restart

fi

