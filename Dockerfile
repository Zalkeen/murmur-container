FROM alpine:3.8
MAINTAINER Grim Kriegor <grimkriegor@krutt.org>

ENV version=1.2.19-r7

RUN apk update \
    && apk add murmur=${version} \
    && rm -rf /var/cache/apk/*

COPY murmur.ini /etc/murmur.ini

EXPOSE 64738/tcp 64738/udp

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/murmurd", "-fg", "-v"]
CMD ["-ini", "/etc/murmur.ini"]
