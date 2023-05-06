#!/usr/bin/env bash

channel=$1

if [[ $channel = "develop" ]]; then
  version=$(curl -sX GET "https://api.github.com/repos/zhaofengli/attic/commits/main" | jq --raw-output '.sha' 2>/dev/null)
  printf "%s" "${version}"
elif [[ $channel = "stable" ]]; then
  # a guess until it is actually released
  version=$(curl -sX GET "https://api.github.com/repos/zhaofengli/attic/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null)
  version="${version#*v}"
  printf "%s" "${version}"
else
  echo "Unsupported channel: ${channel}"
  exit 1
fi
