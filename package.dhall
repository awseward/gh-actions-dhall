let Inputs = ./inputs.dhall

let mkPackage = (./imports.dhall).dhall-misc.GHA.mkPackage

in    mkPackage
        Inputs.Type
        Inputs.{ toJSON }
        "awseward/gh-actions-dhall"
        "0.4.0"
    ⫽ { Inputs }
