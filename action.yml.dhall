let _lib = ./_lib/package.dhall

in    { name = "Dhall Actions"
      , description = "A couple of actions for checking dhall files"
      , runs = Some
        { `using` = "docker"
        , image = "Dockerfile"
        , args = [ "\${{ inputs.dhallVersion }}" ]
        }
      , inputs = ./inputs/package.dhall
      }
    : _lib.ActionSpec
