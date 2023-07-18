FROM ghcr.io/onedr0p/alpine:rolling@sha256:5d973006bf93ba66e38758694dfed6df091a13e712b6a075f7ed7bb6fd8c2189

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN \
  apk add --no-cache ca-certificates git nodejs npm \
  && git clone https://github.com/qlonik/webhook2github /app \
  && git checkout ${VERSION} \
  && npm ci

USER kah

CMD ["npm", "start"]

LABEL org.opencontainers.image.source="https://github.com/qlonik/webhook2github"
