#!/usr/bin/env bash

_black() { echo -ne "\e[0;30m${1}\e[0m" ; }
_green() { echo -ne "\e[0;92m${1}\e[0m" ; }
_red()   { echo -ne "\e[0;91m${1}\e[0m" ; }

_bg_white() { echo -ne "\e[47m${1}\e[0m" ; }

_check_version() {
  local dh_ver; dh_ver="$(dhall --version)"
  IFS='.' read -ra v_parts <<< "${dh_ver}"
  local major="${v_parts[0]}"
  local minor="${v_parts[1]}"

  # Assumes that removal of `--inplace` will release as 1.39.0 of dhall-haskell
  if [ "${major}" -le 1 ] && [ "${minor}" -le 38 ]; then
    >&2 echo -e "$0 -- $(_red 'ERROR'): Minimum version of $(_black "$(_bg_white 'dhall-haskell')") is $(_green '1.39.0'), but found $(_red "${dh_ver}")…"
    return 1
  fi
}
