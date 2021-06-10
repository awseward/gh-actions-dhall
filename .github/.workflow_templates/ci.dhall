let imports = ../imports.dhall

let GHA = imports.GHA

let On = GHA.On

let OS = GHA.OS.Type

let action_templates = imports.action_templates

let Checkout = action_templates.actions/Checkout

in  GHA.Workflow::{
    , name = "CI"
    , on = On.names [ "push" ]
    , jobs = toMap
        { check-Dockerfile = GHA.Job::{
          , runs-on = [ OS.ubuntu-latest ]
          , steps =
              Checkout.plainDo
                [ let a = action_templates.brpaz/Hadolint

                  in  a.mkStep a.Common::{=} a.Inputs::{=}
                ]
          }
        , check-shell = GHA.Job::{
          , runs-on = [ OS.ubuntu-latest ]
          , steps =
              Checkout.plainDo
                [ let a = imports.gh-actions-shell

                  in  a.mkStep a.Common::{=} a.Inputs::{=}
                ]
          }
        , check-dhall = GHA.Job::{
          , runs-on = [ OS.ubuntu-latest ]
          , steps =
              Checkout.plainDo
                [ let a = imports.gh-actions-dhall

                  in  a.mkStep
                        a.Common::{=}
                        a.Inputs::{ dhallVersion = "1.39.0" }
                ]
          }
        }
    }
