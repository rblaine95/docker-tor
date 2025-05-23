# Docker Tor

A very simple Alpine based Docker container for running Tor.

[![Latest Built Tag](https://img.shields.io/github/v/tag/rblaine95/docker-tor?label=Latest%20Built%20Tag)](https://ghcr.io/rblaine95/tor)
[![Latest Tor Tag](https://img.shields.io/gitlab/v/tag/tpo%2Fcore%2Ftor?label=Latest%20Tor%20Tag&gitlab_url=https%3A%2F%2Fgitlab.torproject.org&sort=semver)](https://gitlab.torproject.org/tpo/core/tor/-/tags)

## Usage

```sh
docker run -d --name tor \
  --restart=always \
  -p 9050:9050 \
  -v $(pwd)/tor-data:/var/lib/tor \
  ghcr.io/rblaine95/tor
```

You can configure `torrc` by passing `TOR_` prefixed environment variables.

For example:

```sh
docker run -d --name nginx --restart=always nginx:alpine
docker run -d --name tor \
  --restart=always \
  -p 9050:9050 \
  -v $(pwd)/tor-data:/var/lib/tor \
  -e TOR_HIDDEN_SERVICE_DIR=/var/lib/tor/nginx \
  -e TOR_HIDDEN_SERVICE_PORT="80 nginx:80" \
  -e TOR_HIDDEN_SERVICE_VERSION="3" \
  --link nginx:nginx \
  ghcr.io/rblaine95/tor
```

And then you can get the hostname by running:

```sh
cat $(pwd)/tor-data/nginx/hostname
```

### Multiple Hidden Services

You can run multiple hidden services behind a single tor proxy by passing `${SERVICE_NAME}_TOR_HIDDEN_SERVICE_DIR` and
`${SERVICE_NAME}_TOR_HIDDEN_SERVICE_PORT` environment variables.

For example:

```sh
# Start up a single Nginx as an example
docker run -d --name nginx --restart=always nginx:alpine

# Create 3 hidden services pointed at the same Nginx container
docker run -d --name tor \
  --restart=always \
  -p 9050:9050 \
  -v $(pwd)/tor-data:/var/lib/tor \
  -e NGINX_TOR_HIDDEN_SERVICE_DIR=/var/lib/tor/nginx \
  -e NGINX_TOR_HIDDEN_SERVICE_PORT="80 nginx:80" \
  -e ANOTHER_NGINX_TOR_HIDDEN_SERVICE_DIR=/var/lib/tor/another-nginx \
  -e ANOTHER_NGINX_TOR_HIDDEN_SERVICE_PORT="80 nginx:80" \
  -e TOR_HIDDEN_SERVICE_DIR=/var/lib/tor/other-nginx \
  -e TOR_HIDDEN_SERVICE_PORT="80 nginx:80" \
  -e TOR_HIDDEN_SERVICE_VERSION="3" \
  --link nginx:nginx \
  ghcr.io/rblaine95/tor
```

### Multiple Hidden Service Ports for the same Service Directory

```sh
docker run -d --name nginx --restart=always nginx:alpine

docker run -d --name tor \
  --restart=always \
  -p 9050:9050 \
  -v $(pwd)/tor-data:/var/lib/tor \
  -e NGINX_TOR_HIDDEN_SERVICE_DIR=/var/lib/tor/nginx \
  -e NGINX_A_TOR_HIDDEN_SERVICE_PORT="80 nginx:80" \
  -e NGINX_B_TOR_HIDDEN_SERVICE_PORT="8080 nginx:80" \
  --link nginx:nginx \
  ghcr.io/rblaine95/tor
```

## Tips

If you'd like to tip me, thank you, that's very much appreciated.

Please consider donating to the [Tor Project](https://donate.torproject.org) instead.

If you _really_ want to tip me, thank you kindly.

Monero: `83TeC9hCsZjjUcvNVH6VD64FySQ2uTbgw6ETfzNJa51sJaM6XL4NParSNsKqEQN4znfpbtVj84smigtLBtT1AW6BTVQVQGh`

![XMR Address](https://api.qrserver.com/v1/create-qr-code/?data=83TeC9hCsZjjUcvNVH6VD64FySQ2uTbgw6ETfzNJa51sJaM6XL4NParSNsKqEQN4znfpbtVj84smigtLBtT1AW6BTVQVQGh&amp;size=150x150 "83TeC9hCsZjjUcvNVH6VD64FySQ2uTbgw6ETfzNJa51sJaM6XL4NParSNsKqEQN4znfpbtVj84smigtLBtT1AW6BTVQVQGh")
