FROM python:alpine3.7

ARG PROJECT_NAME="speedtest_cli"
ARG BUILD_VERSION="1.0.0-snapshot"

LABEL \
	LABEL="${PROJECT_NAME}-v${BUILD_VERSION}" \
	VERSION="${BUILD_VERSION}" \
	MAINTAINER="camalot <camalot@gmail.com>"


ADD https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py speedtest_cli

RUN chmod +x speedtest_cli && \
	pip install install pyopenssl && \
	pip install ndg-httpsclient && \
	pip install pyasn1

ENTRYPOINT ["./speedtest_cli"]
