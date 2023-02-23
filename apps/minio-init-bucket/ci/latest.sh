#!/usr/bin/env bash

version=$(curl -sX GET "https://api.github.com/repos/minio/mc/releases/latest" | jq -r ".tag_name")
printf "%s" "${version}"
