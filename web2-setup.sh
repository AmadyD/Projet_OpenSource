#!/bin/bash

if [ ! -f /etc/network/if-up.d/custom-network-config ]; then

  # Install apache
  /usr/bin/apt-get -y install nginx
  
  # Log the X-Forwarded-For
  perl -pi -e  's/^LogFormat "\%h (.* combined)$/LogFormat "%h %{X-Forwarded-For}i $1/' /etc/apache2/apache2.conf
  /usr/sbin/service nginx restart

fi