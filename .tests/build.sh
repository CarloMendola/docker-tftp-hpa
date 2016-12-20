#!/bin/bash

. .tests/functions.sh

echo
echo "===> Build a tiny tftp server image."
run_statement docker build --rm -t tftp-hpa .

echo
echo "===> Show image sizes."
docker images | egrep 'tftp-hpa\b'


echo
echo "WARN: you should docker tag the image"
echo