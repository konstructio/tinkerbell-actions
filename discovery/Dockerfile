FROM alpine:3.13.1

RUN apk add --no-cache util-linux curl

COPY . .

ENTRYPOINT ["/bin/sh","./entrypoint.sh"]
