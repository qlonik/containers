FROM ghcr.io/onedr0p/alpine:rolling@sha256:5d973006bf93ba66e38758694dfed6df091a13e712b6a075f7ed7bb6fd8c2189

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN \
  apk add --no-cache ca-certificates git nodejs npm \
  && git clone https://github.com/qlonik/webhook2github /app \
  && git checkout ${VERSION} \
  && npm ci \
  && install -d -m 0755 -o kah -g kah \
      /app/node_modules/.mf \
      /app/node_modules/.cache

USER kah

CMD ["npm", "start", "--", "--ip", "0.0.0.0"]

LABEL org.opencontainers.image.source="https://github.com/qlonik/webhook2github"
