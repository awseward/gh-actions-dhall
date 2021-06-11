let GHA = (./imports.dhall).dhall-misc.GHA

let Inputs = ./inputs.dhall

let mkStep/next = GHA.actions.mkStep/next Inputs.Type Inputs.{ toJSON }

let mkStep = mkStep/next "awseward/gh-actions-dhall" "0.3.1"

in  { mkStep, mkStep/next, Inputs } ⫽ GHA.Step.{ Common }
