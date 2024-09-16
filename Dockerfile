FROM docker.io/alpine:3

ARG TOR_VERSION="latest"
RUN \
  if [ "$TOR_VERSION" = "latest" ]; then \
    apk add --update --no-cache tor; \
  else \
    apk add --update --no-cache tor="$TOR_VERSION"; \
  fi \
  && chown -R tor /etc/tor

COPY entrypoint.sh /entrypoint.sh
COPY LICENSE /LICENSE

EXPOSE 9050

USER tor

ENV TOR_DATA_DIRECTORY="/var/lib/tor"
ENV TOR_LOG="notice stderr"
ENV TOR_SOCKS_PORT="0.0.0.0:9050"

ENTRYPOINT [ "/entrypoint.sh" ]
