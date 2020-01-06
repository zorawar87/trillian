FROM golang:1.11 as build

ARG GOFLAGS=""
RUN go get -u -t github.com/zorawar87/trillian/
WORKDIR /go/src/github.com/zorawar87/trillian

ENV GO111MODULE=on
RUN go install ./server/trillian_log_signer

COPY config/signer.cfg /
COPY config/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--createtree", "--tlsigner"]
