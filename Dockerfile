FROM golang:1.14.4 AS go-build-env
# download and unarchive ghr
ARG GHR_VERSION=v0.12.0
RUN wget https://github.com/tcnksm/ghr/releases/download/$GHR_VERSION/ghr_${GHR_VERSION}_linux_amd64.tar.gz
RUN tar xvzf ghr_${GHR_VERSION}_linux_amd64.tar.gz

FROM alpine:3.13
ARG GHR_VERSION=v0.12.0
COPY --from=go-build-env /go/ghr_${GHR_VERSION}_linux_amd64/ghr /usr/local/bin/
RUN \
    apk add --no-cache ca-certificates  && \
    mkdir /lib64 && \
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    rm -rf /var/cache/apk/*
