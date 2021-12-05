let ActionSpec = ./ActionSpec.dhall

let JSON =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/JSON/package.dhall

in    { name = "Dhall Actions"
      , description = "A couple of actions for checking dhall files"
      , runs = Some
        { `using` = "docker"
        , image = "Dockerfile"
        , args = [ "\${{ inputs.dhallVersion }}" ]
        }
      , inputs = ./inputs/package.dhall
      }
    : ActionSpec
