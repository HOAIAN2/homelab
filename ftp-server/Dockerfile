FROM alpine:latest

RUN apk add --no-cache vsftpd

COPY entrypoint.sh /bin/entrypoint.sh
COPY config/vsftpd.conf /etc/vsftpd/vsftpd.conf

ENTRYPOINT ["/bin/entrypoint.sh"]