FROM docker.io/library/alpine:3.20

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

USER root
WORKDIR /app

RUN \
  apk add --no-cache git nodejs npm \
    # dependencies for cloudflare workerd binary
    && wget -qO /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget -qO glibc.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk \
    && apk add --no-cache libc6-compat gcompat \
    && apk add --force-overwrite glibc.apk \
    && rm -rf glibc.apk \
  && git clone https://github.com/qlonik/actionsflow-webhook2github /app \
  && git checkout ${VERSION} \
  && rm -rf .git \
  && npm ci \
  && install -d -m 0777 -o root -g root \
      /app/node_modules/.mf \
      /app/node_modules/.cache

CMD ["npm", "start", "--", "--ip", "0.0.0.0"]

LABEL org.opencontainers.image.source="https://github.com/qlonik/actionsflow-webhook2github"
