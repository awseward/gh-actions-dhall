let imports =
      https://raw.githubusercontent.com/awseward/dhall-misc/23bbedf525112d787334849b86caafa3310c4389/action_templates/package.dhall sha256:6a5145962730d7a0c7705a3b70803aaf22ee978f7fc1269aceca27100028ff31

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
