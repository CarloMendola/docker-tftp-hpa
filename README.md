[![Build Status](https://travis-ci.org/ckaserer/docker-tftp-hpa.svg?branch=master)](https://travis-ci.org/ckaserer/docker-tftp-hpa)

**Info:** ARM systems are supported as well. Take a look at the arm branch of the repository.

**Acknowledment:** This repository is based on [](https://github.com/jumanjihouse/docker-tftp-hpa) </br>
Thanks a lot jumanjihouse!

# docker-tftp

## Overview

The image contains:

* H. Peter Anvin's [tftp server](https://git.kernel.org/cgit/network/tftp/tftp-hpa.git/)
* [map file](src/mapfile) to rewrite certain request paths

The runtime image is quite small (roughly 9 MB) since it is based on
[Alpine Linux](https://www.alpinelinux.org/).

---

## dockerfile

```yaml
FROM alpine:3.3

RUN mkdir -p /tftpboot

# Support clients that use backslash instead of forward slash.
COPY mapfile /tftpboot/
RUN find /tftpboot -type f -exec chmod 0444 {} + 

# Do not track further change to /tftpboot.
VOLUME /tftpboot

# http://forum.alpinelinux.org/apk/main/x86_64/tftp-hpa
RUN apk add --no-cache tftp-hpa

EXPOSE 69/udp

RUN adduser -D tftp
RUN chown -R tftp:tftp /tftpboot

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--verbose", "-m", "/tftpboot/mapfile", "-u", "tftp", "--secure", "--ipv4", "/tftpboot"]
```