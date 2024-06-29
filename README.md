# About

Quick and dirty alpine based docker image for [DNSCrypt/doh-server](https://github.com/DNSCrypt/doh-server)


# Build

```sh
docker build -t doh-server:latest .
```


# Run 

```sh
docker run -it -p 3000:3000 doh-server -H 'doh.example.com' -u 8.8.8.8:53  -l 0.0.0.0:3000
```

# Test

See https://developers.cloudflare.com/1.1.1.1/encryption/dns-over-https/make-api-requests/dns-wireformat/

```sh
curl -H 'accept: application/dns-message' -v 'http://127.0.0.1:3000/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB' |hexdump
```