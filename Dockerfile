FROM armhf/alpine:latest

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
