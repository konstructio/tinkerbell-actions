FROM alpine:3.13.1

RUN apk add --no-cache util-linux wget

ARG COLONY_SCOUT_VERSION=0.0.10-rc11
RUN wget https://objectstore.nyc1.civo.com/konstruct-assets/colony-scout/v0.0.10-rc11/colony-scout_\ 0.0.10-rc11_Linux_x86_64.tar.gz && \
    tar -xzvf colony-scout_\ 0.0.10-rc11_Linux_x86_64.tar.gz && \
    chmod +x colony-scout && \
    mv colony-scout /usr/local/bin/

COPY . .

ENTRYPOINT ["/bin/sh","./entrypoint.sh"]
