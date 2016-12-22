FROM armhf/alpine:latest

COPY tftpboot /tftpboot/

VOLUME /tftpboot

# http://forum.alpinelinux.org/apk/main/x86_64/tftp-hpa
RUN apk add --no-cache tftp-hpa

EXPOSE 69/udp

RUN adduser -D tftp
RUN chown -R tftp:tftp /tftpboot

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--verbose", "--ipv4", "-m", "/tftpboot/mapfile", "-u", "tftp", "--secure", "/tftpboot"]
