#!/bin/bash

run_cmd() {
  echo "[RUN] $@"
  "$@"
}

err() {
  echo "[ERROR] $@" >&2
  exit 1
}

run_cmd docker run --rm -t tftp-hpa -V

echo
echo "===> Start server."
run_cmd docker run -d -p 69:69/udp -v .dummy-menu:/tftpboot/site:ro --name tftpd tftp-hpa
ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' tftpd | tr -d '\r')
[ "x" = "x${ip}" ] && err "Is tftpd container running?"
echo "Server is up at $ip"

echo
echo "===> Test that we can download files via tftp client."
echo "---> /site/menu (fully-qualified, forward slashes)"
run_cmd tftp -gr /site/menu $ip
test -s /tmp/menu
grep 'Sample pxe menu' /tmp/menu
echo
echo "---> \site\menu (fully-qualified, backslashes)"
run_cmd tftp -gr \\site\\menu $ip
test -s /tmp/menu
grep 'Sample pxe menu' /tmp/menu
echo
echo "---> pxelinux.0 (not fully-qualified)"
run_cmd tftp -gr pxelinux.0 $ip
test -s /tmp/pxelinux.0
echo
echo "---> /pxelinux.cfg/default"
run_cmd tftp -gr /pxelinux.cfg/default $ip
test -s /tmp/default
echo
echo "---> pxelinux.cfg/F1.msg (should be downcased by map file)"
run_cmd tftp -gr /pxelinux.cfg/F1.msg $ip
test -s /tmp/F1.msg
