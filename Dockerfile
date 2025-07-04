FROM openeuler/go:1.23.4-oe2403lts
LABEL authors="fengchao"

RUN dnf -y install git gcc && \
    go env -w GO111MODULE=on && \
    go env -w CGO_ENABLED=1 && \
    go env -w GONOSUMDB="github.com/opensourceways/*" && \
    dnf clean all

WORKDIR /opt

ENTRYPOINT ["go", "--version"]