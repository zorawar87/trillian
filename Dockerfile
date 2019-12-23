FROM golang:1.11.13 as builder
RUN apt update -qq
RUN apt install -y unzip tree 

# install protobuffer compiler
ADD https://github.com/protocolbuffers/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip /opt/
RUN unzip -qq /opt/protoc-3.5.1-linux-x86_64.zip -d /opt/protoc
ENV PATH "${PATH}:/opt/protoc/bin"

FROM builder as trillian_no_deps

# install certificate transparency
RUN go get -u -t github.com/zorawar87/trillian
WORKDIR /go/src/github.com/zorawar87/trillian

# turn on go modules and resolve dependencies
FROM trillian_no_deps as skeletal_trillian

ENV GO111MODULE=on
RUN go build ./...

# Travis Config section "Generate"
RUN git clone --depth=1 https://github.com/googleapis/googleapis.git "$GOPATH/src/github.com/googleapis/googleapis"
RUN go install \
    github.com/golang/protobuf/proto \
    github.com/golang/protobuf/protoc-gen-go \
    github.com/golang/mock/mockgen \
    golang.org/x/tools/cmd/stringer \
    github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
    github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc

RUN go generate ./...

## DB Integration
FROM skeletal_trillian
RUN apt install -y default-mysql-client-core lsof
ENV MYSQL_HOST db
ENV MYSQL_ROOT_PASSWORD beeblebrox
RUN echo $MYSQL_HOST $MYSQL_ROOT_PASSWORD

#RUN go test ./storage/mysql/...

#RUN sh -c 'yes | ./scripts/resetdb.sh --force --verbose'
#RUN mysql -hdb -p3306 -uroot -pbeeblebrox
#RUN ./integration/integration_test.sh

# Full Test
#RUN go test ./...

# TODO CT Integration
CMD "bash"
