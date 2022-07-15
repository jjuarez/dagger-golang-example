# syntax=docker/dockerfile:1.4
FROM golang:1.18-alpine3.16 AS builder

WORKDIR /build
COPY . ./
RUN go build -o ./service


FROM alpine:3.16 AS runtime
LABEL \
  org.label-schema.name="dagger-golang-example" \
  org.label-schema.description="A dagger.io example for a golang application" \
  org.label-schema.url="https://github.com/jjuarez/dagger-golang-example/"

WORKDIR /app
COPY --from=builder /build/service ./
CMD [ "/app/service" ]
