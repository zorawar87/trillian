FROM golang:1.11 as build

ARG GOFLAGS=""
RUN go get -u -t github.com/zorawar87/trillian/
WORKDIR /go/src/github.com/zorawar87/trillian

ENV GO111MODULE=on
RUN go install ./server/trillian_log_signer

COPY config/signer.cfg /

#FROM alpine
#
#COPY --from=build /go/bin/trillian_log_signer /
#COPY --from=build /go/src/github.com/zorawar87/trillian/config/signer.cfg /


#FROM gcr.io/distroless/base
#
#COPY --from=build /go/bin/trillian_log_signer /
#COPY --from=build /go/src/github.com/zorawar87/trillian/config/signer.cfg /
#
CMD "bash"
#ENTRYPOINT ["/go/bin/trillian_log_signer", "--config=/signer.cfg"]

#FROM trillian_core as build

#WORKDIR /trillian
#
#ARG GOFLAGS=""
#ENV GOFLAGS=$GOFLAGS
#ENV GO111MODULE=on
#
## Download dependencies first - this should be cacheable.
#COPY go.mod go.sum ./
#RUN go mod download
#
## Now add the local Trillian repo, which typically isn't cacheable.
#COPY . .
#
## Build the server.
#RUN go get ./server/trillian_log_server
# Run the licensing tool and save licenses, copyright notices, etc.
#RUN go run github.com/google/go-licenses save ./server/trillian_log_server --save_path /THIRD_PARTY_NOTICES

#FROM alpine

#RUN echo "this is alpine"
#COPY --from=build /go/bin/trillian_log_server /tlserver/
#COPY --from=build /config/server.cfg /tlserver
#COPY --from=build /THIRD_PARTY_NOTICES /THIRD_PARTY_NOTICES

#CMD ["sh ", "-c", "/tlserver/trillian_log_server", "--config=/tlserver/server.cfg"]
#CMD ["bash "]
