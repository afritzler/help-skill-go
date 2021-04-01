FROM golang:1.16.2 AS builder

WORKDIR /go/src/github.com/afritzler/search-conversion
COPY . .

RUN make build-linux

FROM alpine:3.8 AS base

WORKDIR /

FROM base AS search-conversion

COPY --from=builder /go/src/github.com/afritzler/search-conversion/search-conversion_linux_amd64 /search-conversion

ENTRYPOINT ["/search-conversion"]