FROM ghcr.io/onedr0p/alpine:rolling@sha256:3fbc581cb0fe29830376161ae026e2a765dcc11e1747477fe9ebf155720b8638

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV MINIO_USER_RESET="false" \
    MINIO_USER_POLICY_RESET="false" \
    MINIO_ANON_POLICY_RESET="false" \
    MINIO_BUCKET_RESET="false" \
    MINIO_RESET_CONFIRM="NO" \
    MC_CONFIG_DIR="/config"

RUN \
  curl -fsSL -o /usr/local/bin/mc "https://dl.min.io/client/mc/release/${TARGETPLATFORM//\//-}/archive/mc.${VERSION}" \
  && chmod +x /usr/local/bin/mc

USER kah

COPY ./apps/minio-init-bucket/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/minio/mc"
