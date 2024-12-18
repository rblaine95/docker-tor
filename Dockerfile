FROM docker.io/alpine:3

ARG TOR_VERSION="latest"
RUN apk add --update --no-cache curl && \
  if [ "$TOR_VERSION" = "latest" ]; then \
    apk add --update --no-cache tor; \
  else \
    apk add --update --no-cache tor="$TOR_VERSION"; \
  fi \
  && chown -R tor /etc/tor

COPY LICENSE /LICENSE

EXPOSE 9050

HEALTHCHECK --interval=10s --timeout=10s --start-period=5s --retries=3 \
  CMD curl --socks5 localhost:9050 \
      --socks5-hostname localhost:9050 \
      -s \
      -f \
      https://check.torproject.org/api/ip | grep -q '"IsTor":true' || exit 1

USER tor

ENV TOR_DATA_DIRECTORY="/var/lib/tor"
ENV TOR_LOG="notice stderr"
ENV TOR_SOCKS_PORT="0.0.0.0:9050"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
