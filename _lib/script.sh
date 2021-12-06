#!/usr/bin/env bash

set -euo pipefail

help() {
  echo $'Usage:

  For ./inputs/<input_name>/*:

    - setup_input <input_name>
      Sets up the expected files in ./inputs/<input_name>/
      If any already exist, they are not modified

    - setup_inputs <input_name> [additional input names…]
      Sets up multiple inputs at once; expects names space-separated

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

  Misc:

    - write_all
      Writes all of the above

Notes:

  At the time of writing, the expected layout of files is, roughly:

    ├── action.yml.dhall
    └── inputs
        ├── imports.dhall (needs to import & forward JSON from Prelude)
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

  '"$0"' write_all
  ```

  I would like to add some utility for scaffolding these and also potentially
  for keeping them updated.

  Probably could do with some tooling around action.yml.dhall as well…
'
}

list_inputs_by_dir() {
  # shellcheck disable=SC2038
  find ./inputs -mindepth 1 -maxdepth 1 -type d | xargs -n1 basename | sort -u
}

_todo() { >&2 echo '>>>>>>>> TODO <<<<<<<<' && return 1; }

setup_input() {
  local -r input_name="$1"
  local -r dir_path="./inputs/${input_name}"

  mkdir -p "${dir_path}"

  _setup() {
    local -r file_path="${dir_path}/$1"

    if [ ! -f "${file_path}" ]; then
      >&2 echo "Setting up ${file_path}"
      echo "$2" > "${file_path}"
    fi
  }

  # NOTE: Should probably have some kind of interactive flow to choose whether
  # to write or not write some of these files depending on the input:
  #
  #   - default.dhall
  #   - deprecationMessage.txt
  #   - required.dhall
  #
  # Alternatively, these could all just be provided via static file templates,
  # which I'd probably prefer…
  #
  _setup default.dhall "$(dhall format <<< '
    -- If this input has no default value, you can also just remove this file.
    -- Otherwise, consult the Dhall Prelude for valid JSON types…
    --
    (../imports.dhall).JSON.null
  ')"
  # Probably doesn't make a whole lot of sense to have an input depcrated
  # already when just setting it up…
  #
  # _setup deprecationMessage.txt \
  #   'TODO: Write a deprecation message (or delete this file if this input is not deprecated)'
  #
  _setup description.txt \
    'TODO: Write a description'
  # This one should be pretty self-explanatory for the user to change if needed…
  _setup required.dhall 'True'
}

setup_inputs() {
  # shellcheck disable=SC2068
  echo $@ | xargs -n1 "$0" setup_input
}

gen_inputs_pkg() {
  (
    echo '-- This file is automatically generated; please, do not edit it manually'
    echo '{ '
    list_inputs_by_dir | xargs -n2 -I{} echo -n ', {} = ./{}/package.dhall'
    echo '}'
  ) | dhall lint
}

write_inputs_pkg() {
  "$0" gen_inputs_pkg > ./inputs/package.dhall
}

gen_input_pkg() {
  # NOTE: This is now just a plain old file we could just throw straight in
  # without inspecting the target location 🤔
  cat <<< "
    -- This file is automatically generated; please, do not edit it manually
    { default            = ./default.dhall ? (../imports.dhall).JSON.null
    , deprecationMessage = Some ./deprecationMessage.txt as Text ? None Text
    , description        = ./description.txt as Text
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

write_all() {
  xargs -t -n1 "$0" <<< '
    write_input_packages_all
    write_inputs_pkg
    write_action_yml
  '
}

"${@:-help}"
