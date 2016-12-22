# docker-tftp (ARM)

**Acknowledment:** This repository is heavily based on [https://github.com/jumanjihouse/docker-tftp-hpa]() </br>
Thanks a lot jumanjihouse!

The runtime image is quite small since it is based on Alpine Linux.

The goal is to provide a compromise between a single, monolithic tftpd image that contains all the things and a flexible tftpd image that contains just enough to combine with custom-built data containers or volumes an organization needs to bootstrap their infrastructure.

### Configure and run

The published image contains just enough files to provide
a base tftpd to PXE-boot your hosts to a simple menu.
The simple menu ```f1.msg``` and ```pxelinux.cfg/default``` only allow to skip PXE. Therefore you probably want to override the built-in menu.