FROM docker.io/library/alpine:latest AS builder

RUN apk add --no-cache curl xz build-base \
    c-ares-dev expat-dev expat-static \
    sqlite-dev sqlite-static openssl-dev openssl-libs-static \
    zlib-dev zlib-static ca-certificates

ARG ARIA2_VERSION=1.37.0
RUN curl -fsSL "https://github.com/aria2/aria2/releases/download/release-${ARIA2_VERSION}/aria2-${ARIA2_VERSION}.tar.xz" | tar -xJ \
 && cd "aria2-${ARIA2_VERSION}" \
 && sed -i '/OSSL_PROVIDER_load.*legacy/,/}/s/throw DL_ABORT_EX/A2_LOG_WARN/' src/Platform.cc \
 && ARIA2_STATIC=yes ./configure \
    --prefix=/usr \
    --disable-nls \
    --without-gnutls \
    --with-openssl \
    --with-sqlite3 \
    --with-libcares \
    --with-libexpat \
    --with-ca-bundle=/etc/ssl/certs/ca-certificates.crt \
 && make -j$(nproc) \
 && strip src/aria2c \
 && mv src/aria2c /usr/local/bin/aria2c

FROM gcr.io/distroless/static:nonroot

COPY --from=builder /usr/local/bin/aria2c /usr/bin/aria2c

USER nonroot:nonroot

ENTRYPOINT ["/usr/bin/aria2c"]
CMD ["--conf-path=/etc/aria2/aria2.conf"]
