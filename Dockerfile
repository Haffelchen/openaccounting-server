FROM golang:1.19-alpine AS build

RUN apk add --no-cache --update gcc musl-dev libtool make git

COPY . ./oa-server
RUN cd oa-server && go build core/server.go



FROM alpine

COPY --from=build go/oa-server/server /usr/bin/oa-server

ENTRYPOINT ["/usr/bin/oa-server"]
