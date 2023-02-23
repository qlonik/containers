#!/usr/bin/env bash

if [[ \
  -z "${MINIO_HOST}" || \
  -z "${MINIO_SUPER_ACCESS_KEY}" || \
  -z "${MINIO_SUPER_SECRET_KEY}" || \
  -z "${MINIO_BUCKET_NAME}" || \
  -z "${MINIO_BUCKET_PASSWORD}" \
  ]]; then
  printf "\e[1;32m%-6s\e[m\n" "Invalid configuration ..."
  exit 1
fi

export MINIO_BUCKET_USER="${MINIO_BUCKET_USER:-$MINIO_BUCKET_NAME}"

mc alias set minio "${MINIO_HOST}" "${MINIO_SUPER_ACCESS_KEY}" "${MINIO_SUPER_SECRET_KEY}"

until mc ready minio; do
  printf "\e[1;32m%-6s\e[m\n" "Waiting for host '${MINIO_HOST}' ..."
  sleep 1
done

# --- USER --------------------
if [[ "${MINIO_USER_RESET}" == "true" && "${MINIO_RESET_CONFIRM}" == "YES" ]]; then
  printf "\e[1;32m%-6s\e[m\n" "Removing user '${MINIO_BUCKET_USER}' ..."
  mc admin user remove minio "${MINIO_BUCKET_USER}"
fi
user_exists=$(mc admin user info minio "${MINIO_BUCKET_USER}" 2&>/dev/null)
if [[ -z "${user_exists}" ]]; then
  printf "\e[1;32m%-6s\e[m\n" "Creating user '${MINIO_BUCKET_USER}' ..."
  mc admin user add minio "${MINIO_BUCKET_USER}" "${MINIO_BUCKET_PASSWORD}"
fi
# --- USER --------------------

# --- BUCKET ------------------
if [[ "${MINIO_BUCKET_RESET}" == "true" && "${MINIO_RESET_CONFIRM}" == "YES" ]]; then
  printf "\e[1;32m%-6s\e[m\n" "Removing bucket '${MINIO_BUCKET_NAME}' ..."
  mc rb "minio/${MINIO_BUCKET_NAME}"
fi
bucket_exists=$(mc stat "minio/${MINIO_BUCKET_NAME}")
if [[ -z "${bucket_exists}" ]]; then
  printf "\e[1;32m%-6s\e[m\n" "Creating bucket '${MINIO_BUCKET_NAME}' ..."
  mc mb "minio/${MINIO_BUCKET_NAME}"
fi
# --- BUCKET ------------------

# --- USER POLICY -------------
if [[ "${MINIO_USER_POLICY_RESET}" == "true" && "${MINIO_RESET_CONFIRM}" == "YES" ]]; then
  printf "\e[1;32m%-6s\e[m\n" "Removing the policy between user '${MINIO_BUCKET_USER}' and bucket '${MINIO_BUCKET_NAME}' ..."
  mc admin policy remove minio "${MINIO_BUCKET_NAME}-private"
fi
policy_exists=$(mc admin policy info minio "${MINIO_BUCKET_NAME}-private" 2&>/dev/null)
if [[ -z "${policy_exists}" ]]; then
  if [[ -z "${MINIO_USER_POLICY}" ]]; then
    printf "\e[1;32m%-6s\e[m\n" "Create default policy ..."
    cat <<EOF >/tmp/user-policy.json
      {
          "Version": "2012-10-17",
          "Statement": [
              {
                  "Action": [
                      "s3:ListBucket",
                      "s3:PutObject",
                      "s3:GetObject",
                      "s3:DeleteObject"
                  ],
                  "Effect": "Allow",
                  "Resource": ["arn:aws:s3:::${MINIO_BUCKET_NAME}/*", "arn:aws:s3:::${MINIO_BUCKET_NAME}"],
                  "Sid": ""
              }
          ]
      }
EOF
  else
    printf "\e[1;32m%-6s\e[m\n" "Using supplied policy ..."
    echo "${MINIO_USER_POLICY}" >/tmp/user-policy.json
  fi

  printf "\e[1;32m%-6s\e[m\n" "Adding policy ..."
  mc admin policy add minio "${MINIO_BUCKET_NAME}-private" /tmp/user-policy.json
  printf "\e[1;32m%-6s\e[m\n" "Associating policy with the user ..."
  mc admin policy set minio "${MINIO_BUCKET_NAME}-private" "user=${MINIO_BUCKET_USER}"
fi
# --- USER POLICY -------------

# --- ANON POLICY -------------
if [[ "${MINIO_ANON_POLICY_RESET}" == "true" && "${MINIO_RESET_CONFIRM}" == "YES" ]]; then
  printf "\e[1;32m%-6s\e[m\n" "Removing the anonymous policy for bucket '${MINIO_BUCKET_NAME}' ..."
  mc anonymous set none "minio/${MINIO_BUCKET_NAME}"
fi
if [[ ! -z "${MINIO_ANON_POLICY}" ]]; then
  printf "\e[1;32m%-6s\e[m\n" "Using anonymous policy ..."
  echo "${MINIO_ANON_POLICY}" >/tmp/bucket-policy.json
  printf "\e[1;32m%-6s\e[m\n" "Associating anonymous policy with the bucket ..."
  mc anonymous set-json /tmp/bucket-policy.json "minio/${MINIO_BUCKET_NAME}"
fi
# --- ANON POLICY -------------
