# includes static quemu-library for automated builds at TravisCI
FROM hypriot/rpi-alpine:3.6
MAINTAINER netzfisch

# update base system
RUN apk add --update ca-certificates perl perl-net-ip wget \
  && rm -rf /var/cache/apk/*

# install lib ssl
RUN apt-get update && apt-get install -y \
    libio-socket-ssl-perl

# install init script + ddclient-library
WORKDIR /usr/local/bin
COPY init .
RUN wget 'https://raw.githubusercontent.com/ddclient/ddclient/master/ddclient' \
  && sed -i -e 's/Data::Validate/Net/' ddclient \
  && chmod +x ./*

# configure ddclient-library
RUN mkdir /etc/ddclient /var/cache/ddclient
COPY ddclient.conf /etc/ddclient/

ENTRYPOINT ["/usr/local/bin/init"]
