[![Build Status](https://travis-ci.org/ckaserer/docker-tftp-hpa.svg?branch=master)](https://travis-ci.org/ckaserer/docker-tftp-hpa)

**Info:** ARM systems are supported as well. Take a look at the arm branch of the repository.

**Acknowledment:** This repository is based on [https://github.com/jumanjihouse/docker-tftp-hpa]() </br>
Thanks a lot jumanjihouse!

# docker-tftp

The runtime image is quite small since it is based on Alpine Linux.

The goal is to provide a compromise between a single, monolithic tftpd image that contains all the things and a flexible tftpd image that contains just enough to combine with custom-built data containers or volumes an organization needs to bootstrap their infrastructure.
