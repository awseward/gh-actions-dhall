#!/usr/bin/env bash

_check_version() {
  local dh_ver; dh_ver="$(dhall --version)"
  IFS='.' read -ra v_parts <<< "${dh_ver}"
  local major="${v_parts[0]}"
  local minor="${v_parts[1]}"

  # Assumes that removal of `--inplace` will release as 1.39.0 of dhall-haskell
  if [ "${major}" -le 1 ] && [ "${minor}" -le 38 ]; then
    >&2 echo "[ $0 ] ERROR: Minimum version of dhall-haskell is 1.39.0, but found ${dh_ver}"
    return 1
  fi
}
