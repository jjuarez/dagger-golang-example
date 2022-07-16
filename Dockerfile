# syntax=docker/dockerfile:1.4
FROM golang:1.18-alpine3.16 AS builder

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . ./
RUN go build -o ./service ./cmd/*.go


FROM scratch AS runtime
LABEL \
  org.label-schema.name="dagger-golang-example" \
  org.label-schema.description="A dagger.io example for a golang application" \
  org.label-schema.url="https://github.com/jjuarez/dagger-golang-example/"

WORKDIR /
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /build/service ./
USER 1001
EXPOSE 8080/TCP
CMD [ "/service" ]
