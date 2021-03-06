FROM golang:1.10-alpine3.7 AS builder
WORKDIR /go/src/github.com/wzshiming/pic2ascii/
COPY . .
RUN apk add -U gcc libc-dev ffmpeg-dev ffmpeg-libs
RUN go install -tags support_video -a -ldflags '-s -w'  ./cmd/...

FROM alpine:3.7
COPY --from=builder /go/bin/pic2ascii /usr/local/bin/
RUN apk add -U --no-cache ffmpeg-libs
ENTRYPOINT [ "pic2ascii" ]
