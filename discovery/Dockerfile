
FROM alpine:3.13.1 as downloader

ARG COLONY_SCOUT_VERSION=0.2.0-rc1

RUN apk add --no-cache wget

RUN wget https://objectstore.nyc1.civo.com/konstruct-assets/colony-scout/v${COLONY_SCOUT_VERSION}/colony-scout_${COLONY_SCOUT_VERSION}_Linux_x86_64.tar.gz -O ${COLONY_SCOUT_VERSION}.tar.gz && \
    tar -xzvf "${COLONY_SCOUT_VERSION}.tar.gz" && \
    chmod +x colony-scout

FROM alpine:3.13.1

RUN apk add --no-cache util-linux

COPY --from=downloader /colony-scout /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/sh","./entrypoint.sh"]
