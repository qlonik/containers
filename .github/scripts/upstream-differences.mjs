#!/usr/bin/env zx

// Builds a JSON string with changed files
// [
//   {"filename":"metadata.rules.cue", "diff":"diff --git..."}
// ]

$.verbose = false;

const watchedFiles = `
metadata.rules.cue
.github
:^.github/CODEOWNERS
:^.github/ISSUE_TEMPLATE
:^.github/workflows/upstream-schedule.yaml
:^.github/scripts/upstream-differences.mjs
`
  .trim()
  .split("\n");

const upstreamBranch = process.argv[3];

const { stdout: fileNamesStr } =
  await $`git diff ${upstreamBranch} origin/main --name-only -- ${watchedFiles}`;
const fileNames = fileNamesStr.trim().split("\n");

const output = [];
for (const filename of fileNames) {
  const { stdout: diff } =
    await $`git diff --no-color ${upstreamBranch} origin/main -- ${filename}`;

  output.push({ filename, diff });
}

await $`echo differences=${JSON.stringify(output)} >> $GITHUB_OUTPUT`;
