# aria2

[English](README.md) | [简体中文](README.zh-CN.md)

Ultra-minimalist, zero-shell `aria2` container based on `gcr.io/distroless/static:nonroot` with a statically compiled `aria2c` binary.

## Key Highlights

- **Pure Distroless**: Base image is `gcr.io/distroless/static:nonroot`. Contains **NO shell** (`/bin/sh` or `/bin/bash` do not exist), no package managers, and no runtime OS packages.
- **Static Multi-Stage Compilation**: `aria2c` is compiled statically against musl libc on Alpine Linux with `c-ares`, `libexpat`, `sqlite3`, `openssl`, and `zlib`.
- **Minimal Attack Surface**: The container contains only the statically linked `aria2c` binary, CA certificates, and minimal runtime metadata. Runs as non-root (UID 65532).
- **Automated Rolling CI**: Built daily via GitHub Actions with version change detection.
