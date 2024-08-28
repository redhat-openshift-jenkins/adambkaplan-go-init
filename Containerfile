FROM registry.access.redhat.com/ubi9/go-toolset:1.21.11-7.1724661022 as builder
ARG GO_INIT_VERSION="1.0.0"
COPY go.mod go.mod
COPY main.go main.go
RUN go build -ldflags="-X 'main.versionString=${GO_INIT_VERSION}'" -o go-init main.go

FROM registry.access.redhat.com/ubi9/ubi-micro:9.4

COPY --from=builder /opt/app-root/src/go-init /usr/bin/go-init
ENTRYPOINT [ "/usr/bin/go-init" ]
