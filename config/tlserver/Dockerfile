FROM golang:1.11 as build

RUN apt update -qq
RUN apt install -y default-mysql-client-core lsof

ARG GOFLAGS=""
RUN go get -u -t github.com/zorawar87/trillian/
WORKDIR /go/src/github.com/zorawar87/trillian

ENV MYSQL_HOST=db MYSQL_ROOT_PASSWORD=beeblebrox GO111MODULE=on
#RUN bash -c "scripts/resetdb.sh --force --verbose"

RUN go install ./server/trillian_log_server

COPY config/server.cfg /

#FROM alpine
#
#COPY --from=build /go/bin/trillian_log_server /
#COPY --from=build /go/src/github.com/zorawar87/trillian/config/server.cfg /

#CMD "bash"
#FROM gcr.io/distroless/base
#
#COPY --from=build /go/bin/trillian_log_server /
#COPY --from=build /go/src/github.com/zorawar87/trillian/config/server.cfg /
#
RUN ls /go/bin
RUN cat /server.cfg
CMD "bash"
#ENTRYPOINT ["/go/bin/trillian_log_server", "--config=/server.cfg"]

#FROM trillian_core as build

#WORKDIR /trillian
#
#ARG GOFLAGS=""
#ENV GOFLAGS=$GOFLAGS
#ENV GO111MODULE=on
#
## Download dependencies first - this should be cacheable.
#COPY ./go.mod ./go.sum ./
#RUN go mod download
#
## Now add the local Trillian repo, which typically isn't cacheable.
#COPY . .
#
## Build the signer.
#RUN go get ./server/trillian_log_signer
# Run the licensing tool and save licenses, copyright notices, etc.
#RUN go run github.com/google/go-licenses save ./server/trillian_log_signer --save_path /THIRD_PARTY_NOTICES

# Make a minimal image.
#FROM alpine


#CMD ["sh ", "-c", "/tlsigner/trillian_log_signer", "--config=/tlsigner/signer/cfg"]
#CMD ["bash", "-c", "bash"]
