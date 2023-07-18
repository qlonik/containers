# Actionsflow webhook

> **Warning** Do not expose this to the Internet!

This image packages https://github.com/qlonik/actionsflow-webhook2github
project.

This image runs webhook that forwards the request to a specified github
repository and executes a specified
[actionsflow](https://actionsflow.github.io/) workflow.

## Configuration

At the time, this project is implemented as cloudflare worker that runs locally
in the development mode. The service listens on port `8787`. The environment
variables that are passed to it are specified via `/app/.dev.vars` file.

The following variables can be set via above-mentioned `.dev.vars` file.

| variable     | description                                                 |
| ------------ | ----------------------------------------------------------- |
| GITHUB_REPO  | Slug for github repository (e.g. `qlonik/musical-parakeet`) |
| GITHUB_TOKEN | Github PAT with `Content` permission set to `Write`         |

If the variable `GITHUB_REPO` is set, then the `<owner>/<repo>` can be ommitted
from the webhook URL. If the variable `GITHUB_TOKEN` is set, then the `__token`
parameter can be ommitted from the webhook URL. Otherwise, the webhook works as
described on the project page:
https://github.com/qlonik/actionsflow-webhook2github.
