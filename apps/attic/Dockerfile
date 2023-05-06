# This Dockerfile is written based on ideas in
# https://mitchellh.com/writing/nix-with-dockerfiles

FROM nixos/nix:latest@sha256:251a921be086aa489705e31fa5bd59f2dadfa0824aa7f362728dfe264eb6a3d2 AS builder

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

WORKDIR /tmp/build

RUN nix \
  --extra-experimental-features "nix-command flakes" \
  --no-filter-syscalls \
  --accept-flake-config \
  build \
  github:zhaofengli/attic/${VERSION}#attic-server

RUN mkdir /tmp/nix-store-closure
RUN cp -R $(nix-store -qR result/) /tmp/nix-store-closure

FROM ghcr.io/onedr0p/alpine:rolling@sha256:5d973006bf93ba66e38758694dfed6df091a13e712b6a075f7ed7bb6fd8c2189

COPY --from=builder /tmp/nix-store-closure/ /nix/store/
COPY --from=builder /tmp/build/ /app/

USER kah

CMD ["/app/result/bin/atticd"]

LABEL org.opencontainers.image.source="https://github.com/zhaofengli/attic"
