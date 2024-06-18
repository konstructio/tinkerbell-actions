FROM alpine:3.13.1

RUN apk add --no-cache util-linux curl

ARG COLONY_SCOUT_VERSION=0.0.8-rc14
RUN curl -L -o colony-scout.tar.gz https://assets.kubefirst.com/colony/colony-scout_.${COLONY_SCOUT_VERSION}_Linux_x86_64.tar.gz && \
    tar -xzvf colony-scout.tar.gz && \
    chmod +x colony-scout && \
    mv colony-scout /usr/local/bin/

COPY . .

ENTRYPOINT ["/bin/sh","./entrypoint.sh"]
