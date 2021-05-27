FROM alpine:3.13
MAINTAINER Grim Kriegor <grimkriegor@krutt.org>

ENV VERSION 1.3.3-r6

RUN apk update \
    && apk add murmur=${VERSION} \
    && rm -rf /var/cache/apk/*

RUN cp /etc/murmur.ini /etc/murmur.ini.sample \
  && sed -i 's|\(^database=\).*|\1/data/murmur.sqlite|g' /etc/murmur.ini*

ADD entrypoint.sh \
  /entrypoint.sh

EXPOSE 64738/tcp 64738/udp

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]
