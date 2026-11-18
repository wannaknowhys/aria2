# aria2

[English](README.md) | [简体中文](README.zh-CN.md)

基于 `gcr.io/distroless/static:nonroot` 的极致精简无 Shell `aria2` 容器，搭载纯静态编译的 `aria2c` 二进制。

## 核心特性

- **纯粹 Distroless**：底座为 `gcr.io/distroless/static:nonroot`。**完全无 Shell**（无 `/bin/sh`、无 `/bin/bash`），无包管理器，无任何多余 OS 工具。
- **多阶段静态编译**：在 Alpine musl 环境下使用 GCC 将 `c-ares`、`libexpat`、`sqlite3`、`openssl`、`zlib` 等底层库以纯静态形式链接进 `aria2c`。
- **近乎零攻击面**：容器内仅有静态编译的单一 `aria2c` 可执行文件、系统 CA 根证书及极简基础元数据；默认非 root（UID 65532）运行。
- **自动化滚动 CI**：由 GitHub Actions 每日自动探测更新并打标签发布至 GHCR。
