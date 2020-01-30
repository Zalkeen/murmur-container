FROM alpine:3.8
MAINTAINER Grim Kriegor <grimkriegor@krutt.org>

ENV VERSION 1.2.19-r7

RUN apk update \
    && apk add murmur=${VERSION} \
    && rm -rf /var/cache/apk/*

ADD murmur.ini \
  /etc/murmur.ini.sample

ADD entrypoint.sh \
  /entrypoint.sh

EXPOSE 64738/tcp 64738/udp

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]
