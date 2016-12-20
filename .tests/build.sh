#!/bin/bash

basic() {
  echo "[RUN] $@"
  "$@"
}

echo
echo "===> Build a tiny tftp server image."
basic docker build --rm -t tftp-hpa .

echo
echo "===> Show image sizes."
docker images | egrep 'tftp-hpa\b'


echo
echo "WARN: you should docker tag the image"
echo