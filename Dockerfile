FROM alpine:3.3

RUN mkdir -p /tftpboot

# Support clients that use backslash instead of forward slash.
COPY mapfile /tftpboot/

# Do not track further change to /tftpboot.
VOLUME /tftpboot

# http://forum.alpinelinux.org/apk/main/x86_64/tftp-hpa
RUN apk add --no-cache tftp-hpa

EXPOSE 69/udp

RUN adduser -D tftp

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--verbose", "-m", "/tftpboot/mapfile", "-u", "tftp", "--secure", "--ipv4", "/tftpboot"]
