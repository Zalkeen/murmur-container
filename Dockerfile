FROM alpine:3.8
LABEL maintainer="Joel Luth <joel.luth@gmail.com>"
LABEL description="A murmur container based on alpine"

ENV version=1.2.19-r6

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
