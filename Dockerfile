FROM elyase/pyrun:2.7

ARG PROJECT_NAME="deluge"
ARG BUILD_VERSION="1.0.0-snapshot"

LABEL \
	LABEL="${PROJECT_NAME}-v${BUILD_VERSION}" \
	VERSION="${BUILD_VERSION}" \
	MAINTAINER="camalot <camalot@gmail.com>"


ADD https://raw.github.com/sivel/speedtest-cli/master/speedtest_cli.py speedtest_cli

RUN chmod +x speedtest_cli

ENTRYPOINT ["./speedtest_cli"]
