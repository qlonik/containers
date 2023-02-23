# minio-init-bucket

The `entrypoint.sh` script is based on [onedr0p's docs](https://github.com/onedr0p/home-ops/blob/45bc09c39d0eb59ad11045e878c38df3f4d84ce0/docs/src/notes/s3-buckets.md#minio)

## Accepted inputs

This image accept the following environment variables

| variable                | required | description                                                                        |
| ----------------------- | -------- | ---------------------------------------------------------------------------------- |
| MINIO_HOST              | ✔️       | Address of s3 compatible host (e.g. `http://minio.default.svc.cluster.local:9000`) |
| MINIO_SUPER_ACCESS_KEY  | ✔️       | Minio root user access key                                                         |
| MINIO_SUPER_SECRET_KEY  | ✔️       | Minio root user secret key                                                         |
| MINIO_BUCKET_NAME       | ✔️       | Name of the bucket to create                                                       |
| MINIO_BUCKET_USER       | ❌       | Account accessing the bucket. By default equals to `BUCKET_NAME`                   |
| MINIO_BUCKET_PASSWORD   | ✔️       | Account password                                                                   |
| MINIO_USER_POLICY       | ❌       | Policy to accociate between the user and the bucket. Default in `entrypoint.sh`    |
| MINIO_ANON_POLICY       | ❌       | Policy for anonymous access to the bucket. By default no public access is allowed  |
| MINIO_USER_RESET        | ❌       | Set to `"true"` to remove user                                                     |
| MINIO_USER_POLICY_RESET | ❌       | Set to `"true"` to remove user policy                                              |
| MINIO_ANON_POLICY_RESET | ❌       | Set to `"true"` to remove anonymous bucket policy                                  |
| MINIO_BUCKET_RESET      | ❌       | Set to `"true"` to remove bucket                                                   |
| MINIO_RESET_CONFIRM     | ❌       | Set to `"YES"` to confirm any of the above removals                                |
