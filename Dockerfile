FROM golang:1.11 as build

RUN apt update -qq
RUN apt install -y default-mysql-client-core lsof

ARG GOFLAGS=""
RUN go get -u -t github.com/zorawar87/trillian/
WORKDIR /go/src/github.com/zorawar87/trillian

ENV GO111MODULE=on MYSQL_HOST=mysql MYSQL_USER=test MYSQL_PASSWORD=zaphod MYSQL_ROOT_PASSWORD=beeblebrox

COPY config/signer.cfg /
COPY config/server.cfg /
COPY config/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
