FROM alpine:3.21

ENV SSH_PORT=22
ENV SSH_KEY_PATH=/root/.ssh/id_ed25519
ENV SOCKS_PORT=1080

EXPOSE 1080

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    apk add --no-cache openssh sshpass && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

ENTRYPOINT ["/entrypoint.sh"]
