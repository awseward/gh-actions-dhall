let mkPackage =
      https://raw.githubusercontent.com/awseward/dhall-misc/add-mkPackage/GHA/mkPackage.dhall

let Inputs = ./inputs.dhall

in    mkPackage
        Inputs.Type
        Inputs.{ toJSON }
        "awseward/gh-actions-dhall"
        "0.4.0"
    ⫽ { Inputs }
