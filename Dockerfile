# includes static quemu-library for automated builds at TravisCI
# For RPI use => hypriot/rpi-alpine:3.6
FROM alpine:latest
MAINTAINER netzfisch

# update base system
RUN apk add --update ca-certificates perl perl-net-ip perl-io-socket-ssl wget \
  && rm -rf /var/cache/apk/*

# install init script + ddclient-library
WORKDIR /usr/local/bin
COPY init checkip.sh ./
RUN wget 'https://raw.githubusercontent.com/ddclient/ddclient/master/ddclient' \
  && sed -i -e 's/Data::Validate/Net/' ddclient \
  && chmod +x ./*

# configure ddclient-library
RUN mkdir /etc/ddclient /var/cache/ddclient
COPY ddclient.conf /etc/ddclient/

ENTRYPOINT ["/usr/local/bin/init"]
