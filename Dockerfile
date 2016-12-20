FROM alpine:latest
MAINTAINER clemens.kaserer@gmail.com

RUN apk add --no-cache --virtual sl_plus_deps syslinux=6.03-r2 && \
    cp -r /usr/share/syslinux /tftpboot && \
    find /tftpboot -type f -exec chmod 0444 {} + && \
    apk del sl_plus_deps

COPY pxelinux.cfg /tftpboot/pxelinux.cfg/

# Support clients that use backslash instead of forward slash.
COPY mapfile /tftpboot/

# Do not track further change to /tftpboot.
VOLUME /tftpboot

RUN apk add --no-cache tftp-hpa

EXPOSE 69/udp

RUN adduser -D tftp

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--verbose", "-m", "/tftpboot/mapfile", "-u", "tftp", "--secure", "/tftpboot"]