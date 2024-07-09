FROM docker.io/library/alpine:3.20

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV MINIO_USER_RESET="false" \
    MINIO_USER_POLICY_RESET="false" \
    MINIO_ANON_POLICY_RESET="false" \
    MINIO_BUCKET_RESET="false" \
    MINIO_RESET_CONFIRM="NO" \
    MC_CONFIG_DIR="/app"

RUN \
  apk add --no-cache curl \
  && curl -fsSL -o /usr/local/bin/mc "https://dl.min.io/client/mc/release/${TARGETPLATFORM//\//-}/archive/mc.${VERSION}" \
  && chmod +x /usr/local/bin/mc

COPY ./apps/minio-init-bucket/entrypoint.sh /entrypoint.sh

USER root
WORKDIR /app

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/minio/mc"
