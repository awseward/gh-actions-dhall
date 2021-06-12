let imports = ../imports.dhall

let GHA = imports.GHA

let On = GHA.On

let OS = GHA.OS.Type

let job-templates = imports.job-templates

let Checkout = job-templates.actions/Checkout

in  GHA.Workflow::{
    , name = "CI"
    , on = On.names [ "push" ]
    , jobs = toMap
        { check-Dockerfile = GHA.Job::{
          , runs-on = [ OS.ubuntu-latest ]
          , steps =
              Checkout.plainDo
                [ let a = job-templates.brpaz/Hadolint

                  in  a.mkStep a.Common::{=} a.Inputs::{=}
                ]
          }
        , check-shell = GHA.Job::{
          , runs-on = [ OS.ubuntu-latest ]
          , steps =
              Checkout.plainDo
                [ let a = imports.actions-catalog.awseward/gh-actions-shell

                  in  a.mkStep a.Common::{=} a.Inputs::{=}
                ]
          }
        , check-dhall = GHA.Job::{
          , runs-on = [ OS.ubuntu-latest ]
          , steps =
              Checkout.plainDo
                [ let a = imports.gh-actions-dhall

                  in  a.mkStep a.Common::{=} a.Inputs::{=}
                ]
          }
        }
    }
