# syntax=docker/dockerfile:1.4
FROM golang:1.18-alpine3.16 AS builder

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . ./
RUN go build -o ./service cmd/main.go


FROM alpine:3.16 AS debug

WORKDIR /app
COPY --from=builder /build/service ./service
ENV PORT=8080
CMD [ "/app/service" ]


FROM scratch AS runtime
LABEL \
  org.label-schema.name="dagger-golang-example" \
  org.label-schema.description="A dagger.io example for a golang application" \
  org.label-schema.url="https://github.com/jjuarez/dagger-golang-example/"

ARG UID=1001

WORKDIR /app
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /build/service ./service
USER ${UID}
ENV PORT=8080
CMD [ "/app/service" ]
