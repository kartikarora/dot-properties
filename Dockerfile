FROM alpine:latest

WORKDIR /app
COPY . /app

RUN apk add --no-cache bash

RUN chmod +x /app/main.sh

ENTRYPOINT [ "/app/main.sh" ]