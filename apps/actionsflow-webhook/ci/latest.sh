#!/usr/bin/env bash

version=$(curl -sX GET "https://api.github.com/repos/qlonik/webhook2github/commits/main" | jq -r ".sha")
printf "%s" "${version}"
