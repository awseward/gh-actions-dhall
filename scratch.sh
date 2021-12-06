#!/usr/bin/env bash

set -euo pipefail

help() {
  echo $'Usage:

  For ./inputs/package.dhall:
    - gen_inputs_pkg
      Generates (but does not write) ./inputs/package.dhall

    - write_inputs_pkg
      Writes ./inputs/package.dhall

  For ./inputs/<input_name>/package.dhall:

    - gen_input_pkg <input_name>
      Generates a Dhall expression reflecting ./inputs/<input_name>/*

    - write_input_package <input_name>
      Writes ./inputs/<input_name>/package.dhall per ./inputs/<input_name>/*

    - write_input_packages_all
      Applies `write_input_package` to all inputs present under ./inputs/

  For action.yml:

    - gen_action_yml
      Generates a YAML document per action.yml.dhall and ./inputs/*

    - write_action_yml
      Writes action.yml per action.yml.dhall and ./inputs/*

NOTE: Current "bootstrap" (kind of) looks like this (replacing <script> with
the actual script filepath):

    ```sh
    <script> write_input_packages_all
    <script> write_inputs_pkg
    <script> write_action_yml
    ```

  I say "kind of" because this not help scaffold or populate any of the
  files it expects, which at the time of writing, are:

    .
    ├── action.yml.dhall
    └── inputs
        ├── <input_name>
        │   ├── default.dhall
        │   ├── description
        │   └── required.dhall
        ├── <input_name>
        │   └── …
        ├── <input_name>
        │   └── …
        ├── …

  To do a kind of "reset and check", you can run this:

  ```sh
  # Before doing this, make sure you have whichever of these you would be sad
  # to lose tracked in source control
  rm -rf action.yml ./inputs/*/package.dhall ./inputs/package.dhall

  # … run the "boostrap" lines from above
  ```

  I would like to add some utility for scaffolding these and also potentially
  for keeping them updated.

  Probably could do with some tooling around `action.yml.dhall` as well…
'
}

list_inputs_by_dir() {
  # shellcheck disable=SC2038
  find ./inputs -mindepth 1 -maxdepth 1 -type d | xargs -n1 basename | sort -u
}

_todo() { >&2 echo '>>>>>>>> TODO <<<<<<<<' && return 1; }

gen_inputs_pkg() {
  (
    echo -n 'toMap { '
    list_inputs_by_dir | xargs -n2 -I{} echo -n ', {} = ./{}/package.dhall'
    echo -n '}'
  ) | dhall lint
}

write_inputs_pkg() {
  "$0" gen_inputs_pkg > ./inputs/package.dhall
}

gen_input_pkg() {
  readonly input_name="$1"
  readonly dir_path="./inputs/${input_name}"

  if [ -f "${dir_path}/deprecationMessage.txt" ]; then
    readonly dep_msg_expr="Some (./deprecationMessage.txt as Text)"
  else
    readonly dep_msg_expr='None Text'
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
" | dhall lint
}

write_input_package() {
  readonly input_name="$1"
  readonly dir_path="./inputs/${input_name}"

  "$0" gen_input_pkg "${input_name}" > "${dir_path}/package.dhall"
}

write_input_packages_all() {
  "$0" list_inputs_by_dir | xargs -t -n1 "$0" write_input_package
}

gen_action_yml() {
  # shellcheck disable=SC2068
  dhall-to-yaml --documents --generated-comment --omit-empty $@ <<< \
    ./action.yml.dhall
}

write_action_yml() {
  "$0" gen_action_yml --output ./action.yml
}

"${@:-help}"
