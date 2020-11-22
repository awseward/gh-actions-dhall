#!/usr/bin/env bash

set -euo pipefail

find . -type f -name '*.dhall' | while read -r fpath; do
  echo "${fpath}" | xargs -t dhall lint --inplace
done

git diff --color=always --exit-code
