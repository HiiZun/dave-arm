FROM golang:1.21-alpine AS build
WORKDIR $GOPATH/src/github.com/micromata/dave/
COPY . .
RUN GOARCH=arm64 GOOS=linux go build -o /go/bin/dave cmd/dave/main.go
RUN GOARCH=arm64 GOOS=linux go build -o /go/bin/davecli cmd/davecli/main.go

FROM alpine:latest
RUN adduser -S dave
COPY --from=build /go/bin/davecli /usr/local/bin
COPY --from=build /go/bin/dave /usr/local/bin
USER dave
ENTRYPOINT ["/usr/local/bin/dave"]
