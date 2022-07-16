# syntax=docker/dockerfile:1.4
FROM golang:1.18-alpine3.16 AS builder

ARG VERSION="v0.0.0"

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . ./
RUN go build -ldflags "-X main.Version=${VERSION}" -o ./service cmd/main.go


FROM alpine:3.16 AS debug
LABEL \
  org.label-schema.name="dagger-golang-example" \
  org.label-schema.description="A dagger.io example for a golang application" \
  org.label-schema.url="https://github.com/jjuarez/dagger-golang-example/"

ARG UID=1001

COPY --from=builder /etc/passwd /etc/passwd
WORKDIR /app
USER ${UID}
COPY --from=builder --chown=${UID}:${UID} /build/service ./service
CMD [ "/app/service" ]
