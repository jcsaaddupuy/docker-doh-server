FROM alpine as builder

ARG VERSION=0.9.9

RUN apk update
RUN apk add \
    wget \ 
    tar \
    xz

RUN wget https://github.com/DNSCrypt/doh-server/releases/download/${VERSION}/doh-proxy_${VERSION}_linux-x86_64.tar.bz2 && \
    tar xvf doh-proxy_${VERSION}_linux-x86_64.tar.bz2  && \
    chmod +x doh-proxy/doh-proxy && \
    mv doh-proxy/doh-proxy /usr/local/bin

RUN rm -rf doh-proxy/ && \
    rm -rf doh-proxy_${VERSION}_linux-x86_64.tar.bz2


FROM alpine
RUN apk update && apk add curl
COPY --from=builder /usr/local/bin/doh-proxy /usr/local/bin/doh-proxy

# health
COPY --chown=root:root ./healthcheck.sh /healthcheck.sh
HEALTHCHECK CMD /healthcheck.sh

ENTRYPOINT [ "doh-proxy" ]