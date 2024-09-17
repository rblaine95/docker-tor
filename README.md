# Docker Tor

A very simple Alpine based Docker container for running Tor.

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

# Create 2 hidden services pointed at the same Nginx container
docker run -d --name tor \
  --restart=always \
  -p 9050:9050 \
  -v $(pwd)/tor-data:/var/lib/tor \
  -e NGINX_TOR_HIDDEN_SERVICE_DIR=/var/lib/tor/nginx \
  -e NGINX_TOR_HIDDEN_SERVICE_PORT="80 nginx:80" \
  -e ANOTHER_NGINX_TOR_HIDDEN_SERVICE_DIR=/var/lib/tor/another-nginx \
  -e ANOTHER_NGINX_TOR_HIDDEN_SERVICE_PORT="80 nginx:80" \
  -e TOR_HIDDEN_SERVICE_VERSION="3" \
  --link nginx:nginx \
  ghcr.io/rblaine95/tor
```

## Tips

If you'd like to tip me, thank you, that's very much appreciated.

Please consider donating to the [Tor Project](https://donate.torproject.org)instead.

If you _really_ want to tip me, thank you kindly.

Monero: `83TeC9hCsZjjUcvNVH6VD64FySQ2uTbgw6ETfzNJa51sJaM6XL4NParSNsKqEQN4znfpbtVj84smigtLBtT1AW6BTVQVQGh`

![XMR Address](https://api.qrserver.com/v1/create-qr-code/?data=83TeC9hCsZjjUcvNVH6VD64FySQ2uTbgw6ETfzNJa51sJaM6XL4NParSNsKqEQN4znfpbtVj84smigtLBtT1AW6BTVQVQGh&amp;size=150x150 "83TeC9hCsZjjUcvNVH6VD64FySQ2uTbgw6ETfzNJa51sJaM6XL4NParSNsKqEQN4znfpbtVj84smigtLBtT1AW6BTVQVQGh")
