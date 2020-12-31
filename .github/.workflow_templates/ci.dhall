let imports = ../imports.dhall

let GHA = imports.action_templates.gha/jobs

let uses = GHA.Step.uses

let check-shell = imports.gh-actions-shell

let check-dhall = imports.gh-actions-dhall

let checkedOut = imports.checkedOut

in  { name = "CI"
    , on = [ "push" ]
    , jobs = toMap
        { check-Dockerfile =
          { runs-on = [ "ubuntu-latest" ]
          , steps =
              checkedOut
                [ uses GHA.Uses::{ uses = "brpaz/hadolint-action@v1.1.0" } ]
          }
        , check-shell =
          { runs-on = [ "ubuntu-latest" ]
          , steps = checkedOut [ check-shell.mkJob check-shell.Inputs::{=} ]
          }
        , check-dhall =
          { runs-on = [ "ubuntu-latest" ]
          , steps =
              checkedOut
                [ check-dhall.mkJob
                    check-dhall.Inputs::{ dhallVersion = "1.37.1" }
                ]
          }
        }
    }
