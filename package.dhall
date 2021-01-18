let imports =
      { GHA =
          https://raw.githubusercontent.com/awseward/dhall-misc/6d2575a022387ceeb44412b15e8854e6a5f7f9de/GHA/package.dhall sha256:895094e0c18a06217f82e6cf87fa543e555c93827386f72a22645c0046cfc796
      }

let GHA = imports.GHA

let name = "awseward/gh-actions-dhall"

let version = "0.2.7"

let Inputs = ./inputs.dhall

let mkStep =
      GHA.actions.mkStep
        name
        version
        Inputs.Type
        (λ(inputs : Inputs.Type) → toMap inputs)

in  { mkStep, Inputs } ⫽ GHA.Step.{ Common }
