FROM arm32v6/alpine:3.7
MAINTAINER Joel Luth <joel.luth@gmail.com>

ENV version=1.2.19-r4

# Add murmur package
RUN apk update \
    && apk add murmur=${version} \
    && rm -rf /var/cache/apk/*

# Copy in our slightly tweaked INI which points to our volume
COPY murmur.ini /etc/murmur.ini

# Forward apporpriate ports
EXPOSE 64738/tcp 64738/udp

# Read murmur.ini and murmur.sqlite from /data/
VOLUME ["/data"]

# Run murmur
ENTRYPOINT ["/usr/bin/murmurd", "-fg", "-v"]
CMD ["-ini", "/etc/murmur.ini"]
