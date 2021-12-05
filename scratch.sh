#!/usr/bin/env bash

set -euo pipefail

readonly dir_path="$1"
readonly json_expr="${2:-https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/JSON/Type.dhall}"

if [ -f "${dir_path}/deprecationMessage.txt" ]; then
  dep_msg_expr="Some (${dir_path}/deprecationMessage.txt as Text)"
else
  dep_msg_expr='None Text'
fi

if [ -f "${dir_path}/default.dhall" ]; then
  :
  default_expr="Some ${dir_path}/default.dhall"
else
  default_expr='None JSON.Type'
fi

cat <<< "
let JSON = ${json_expr}

in  { default = ${default_expr}
    , deprecationMessage = ${dep_msg_expr}
    , description = ${dir_path}/description as Text
    , required = ${dir_path}/required.dhall
    }
"
