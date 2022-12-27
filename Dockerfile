# ----------------------------------
# node version 14.0.0
# Environment: NodeJS
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM node:14-alpine

MAINTAINER Bradd Evans, <bread@breadhub.co.uk>

RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig \
    && adduser --disabled-password --home /home/container container

RUN curl -fsSL "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" -o /bin/pnpm; chmod +x /bin/pnpm; \
    ln -s /bin/pnpm /usr/local/bin/pnpm

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

COPY container /tmpstore/container/

CMD ["/bin/bash", "/entrypoint.sh"]