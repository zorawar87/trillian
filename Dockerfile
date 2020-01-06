FROM golang:1.11 

RUN apt update -qq
RUN apt install -y default-mysql-client-core lsof vim

RUN go get -u -t github.com/zorawar87/trillian/
WORKDIR /go/src/github.com/zorawar87/trillian

COPY config/docker-entrypoint.sh /
COPY config/signer.cfg /
COPY config/server.cfg /

ENV GO111MODULE=on MYSQL_HOST=mysql MYSQL_USER=test MYSQL_PASSWORD=zaphod MYSQL_ROOT_PASSWORD=beeblebrox

RUN go get -u -t github.com/zorawar87/certificate-transparency-go


ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
