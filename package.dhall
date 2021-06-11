let imports =
      { GHA =
          https://raw.githubusercontent.com/awseward/dhall-misc/20210611190215/GHA/package.dhall
            sha256:63ce19a4db5a6b576093f4bc8927abec94fd26672e8cda9f3feaa1e2c8125a68
      }

let GHA = imports.GHA

let Inputs = ./inputs.dhall

let mkStep/next = GHA.actions.mkStep/next Inputs.Type Inputs.{ toJSON }

let mkStep = mkStep/next "awseward/gh-actions-dhall" "0.3.1"

in  { mkStep, mkStep/next, Inputs } ⫽ GHA.Step.{ Common }
