let Inputs = ./inputs.dhall

let GHA = (./imports.dhall).dhall-misc.GHA

let mkStep/next = GHA.actions.mkStep/next Inputs.Type Inputs.{ toJSON }

let mkStep = mkStep/next "awseward/gh-actions-dhall" "0.4.0"

in  { mkStep, mkStep/next, Inputs } ⫽ GHA.Step.{ Common }
