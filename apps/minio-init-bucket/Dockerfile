FROM ghcr.io/onedr0p/alpine:rolling@sha256:5d973006bf93ba66e38758694dfed6df091a13e712b6a075f7ed7bb6fd8c2189

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV MINIO_USER_RESET="false" \
    MINIO_USER_POLICY_RESET="false" \
    MINIO_ANON_POLICY_RESET="false" \
    MINIO_BUCKET_RESET="false" \
    MINIO_RESET_CONFIRM="NO"

RUN \
  curl -fsSL -o /usr/local/bin/mc "https://dl.min.io/client/mc/release/${TARGETPLATFORM//\//-}/archive/mc.${VERSION}" \
  && chmod +x /usr/local/bin/mc

USER kah

COPY ./apps/minio-init-bucket/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/minio/mc"
