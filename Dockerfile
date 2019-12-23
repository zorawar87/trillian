FROM golang:1.11.13 as builder
RUN apt update -qq
RUN apt install -y unzip default-mysql-client-core lsof

# install protobuffer compiler
ADD https://github.com/protocolbuffers/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip /opt/
RUN unzip -qq /opt/protoc-3.5.1-linux-x86_64.zip -d /opt/protoc
ENV PATH "${PATH}:/opt/protoc/bin"

# install trillian
FROM builder as skeletal_trillian
RUN go get -u -t github.com/zorawar87/trillian
WORKDIR /go/src/github.com/zorawar87/trillian
ENV GO111MODULE=on
RUN go build ./...

# Build Developer dependencies (Travis:Generate)
RUN git clone --depth=1 https://github.com/googleapis/googleapis.git "$GOPATH/src/github.com/googleapis/googleapis"
RUN go install \
    github.com/golang/protobuf/proto \
    github.com/golang/protobuf/protoc-gen-go \
    github.com/golang/mock/mockgen \
    golang.org/x/tools/cmd/stringer \
    github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
    github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/uber/prototool/cmd/prototool

RUN go generate -x ./...

## DB Integration
FROM skeletal_trillian
ENV MYSQL_HOST=db MYSQL_ROOT_PASSWORD=beeblebrox

# Tests
#RUN go test ./...
RUN go test ./storage/mysql/...

CMD "./integration/integration_test.sh"
