#!/usr/bin/env bash
# mise provisions everything declared in this profile's mise.toml, so it has to
# exist before --packages runs. Homebrew itself is still installed separately.
if ! command -v mise >/dev/null 2>&1; then
  command -v brew >/dev/null 2>&1 ||
    die "Install Homebrew, or install mise manually from https://mise.jdx.dev, then run again"
  run brew install mise
fi

# The github: and aqua: backends query the GitHub API, which allows 60 requests
# an hour unauthenticated: enough tools in one run exhaust it and the installs
# fail with 403. Borrow the gh CLI's token when there is one, so no credential
# has to live in this repository.
if [[ -z "${GITHUB_TOKEN:-}" ]] && command -v gh >/dev/null 2>&1; then
  GITHUB_TOKEN=$(gh auth token 2>/dev/null) && export GITHUB_TOKEN
fi
