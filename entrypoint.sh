#!/bin/sh

if [ ! -s /etc/murmur.ini ]; then
  echo "Empty /etc/murmur.ini, populating..."
  cat /etc/murmur.ini.sample > \
    /etc/murmur.ini
fi

eval /usr/bin/murmurd \
  -fg \
  -v \
  -ini /etc/murmur.ini
