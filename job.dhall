let imports =
      https://raw.githubusercontent.com/awseward/dhall-misc/43f250d9c743ca2d06cc9f849015f021bdb6b53b/action_templates/package.dhall sha256:b8414ded01b53ae4f4a0452245a8f5d667950cb7ef1c8b34b74dc6f6b25c174b

let GHA = imports.gha/jobs

let uses = GHA.Step.uses

let Inputs = { Type = { dhallVersion : Text }, default.dhallVersion = "1.36.0" }

let mkJob =
      λ(inputs : Inputs.Type) →
        uses
          GHA.Uses::{
          , uses = "awseward/gh-actions-dhall@0.2.2"
          , `with` = toMap inputs
          }

in  { mkJob, Inputs }
