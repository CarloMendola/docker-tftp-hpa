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
[ "$?" -eq "0" ] || return $EXIT_FAILURE

echo
echo "===> Start server."
run_cmd docker run -d -v $(pwd)/.tests/fixtures:/tftpboot/site:ro --name tftpd tftp-hpa
[ "$?" -eq "0" ] || return $EXIT_FAILURE
ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' tftpd | tr -d '\r')
[ "$?" -eq "0" ] || return $EXIT_FAILURE
[ "x" = "x${ip}" ] && err "Is tftpd container running?"
echo "Server is up at $ip"

cd /tmp

echo
echo "===> Test that we can download files via tftp client."
echo "---> /site/menu (fully-qualified, forward slashes)"
run_cmd tftp $ip -c get /site/menu
[ "$?" -eq "0" ] || return $EXIT_FAILURE
test -s /tmp/menu
[ "$?" -eq "0" ] || return $EXIT_FAILURE
grep 'Sample pxe menu' /tmp/menu
[ "$?" -eq "0" ] || return $EXIT_FAILURE
echo
echo "---> \site\menu (fully-qualified, backslashes)"
run_cmd tftp $ip -c get \\site\\menu
[ "$?" -eq "0" ] || return $EXIT_FAILURE
test -s /tmp/menu
[ "$?" -eq "0" ] || return $EXIT_FAILURE
grep 'Sample pxe menu' /tmp/menu
[ "$?" -eq "0" ] || return $EXIT_FAILURE
echo
echo "---> pxelinux.0 (not fully-qualified)"
run_cmd tftp $ip -c get pxelinux.0
[ "$?" -eq "0" ] || return $EXIT_FAILURE
test -s /tmp/pxelinux.0
[ "$?" -eq "0" ] || return $EXIT_FAILURE
echo
echo "---> /pxelinux.cfg/default"
run_cmd tftp $ip -c get /pxelinux.cfg/default
[ "$?" -eq "0" ] || return $EXIT_FAILURE
test -s /tmp/default
[ "$?" -eq "0" ] || return $EXIT_FAILURE
echo
echo "---> pxelinux.cfg/F1.msg (should be downcased by map file)"
run_cmd tftp $ip -c get /pxelinux.cfg/F1.msg
test -s /tmp/F1.msg
