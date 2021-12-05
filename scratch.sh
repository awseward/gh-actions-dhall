#!/usr/bin/env bash

set -euo pipefail

readonly dir_path="$1"

if [ -f "${dir_path}/deprecationMessage.txt" ]; then
  dep_msg_expr="Some (./deprecationMessage.txt as Text)"
else
  dep_msg_expr='None Text'
fi

if [ -f "${dir_path}/default.dhall" ]; then
  default_expr="Some ./default.dhall"
else
  default_expr="None JSON.Type"
  readonly json_expr="${2:-"$(yaml-to-dhall <<< '[{}, 0]' | dhall type | tail -n +2)"}"
  echo "let JSON = ${json_expr} in"
fi

cat <<< "
{ default            = ${default_expr}
, deprecationMessage = ${dep_msg_expr}
, description        = ./description as Text
, required           = ./required.dhall
}
" | dhall lint > "${dir_path}/package.dhall"
