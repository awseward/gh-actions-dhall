let imports = ../imports.dhall

let GHA = imports.GHA

let Checkout = imports.action_templates.actions/Checkout

let On = GHA.On

let mkUses = GHA.Step.mkUses

in  GHA.Workflow::{
    , name = "CI"
    , on = On.names [ "push" ]
    , jobs = toMap
        { check-Dockerfile = GHA.Job::{
          , runs-on = [ "ubuntu-latest" ]
          , steps =
              Checkout.plainDo
                [ [ mkUses
                      GHA.Step.Common::{=}
                      GHA.Step.Uses::{ uses = "brpaz/hadolint-action@v1.1.0" }
                  ]
                ]
          }
        , check-shell = GHA.Job::{
          , runs-on = [ "ubuntu-latest" ]
          , steps =
              Checkout.plainDo
                [ [ let action = imports.gh-actions-shell

                    in  action.mkStep action.Common::{=} action.Inputs::{=}
                  ]
                ]
          }
        , check-dhall = GHA.Job::{
          , runs-on = [ "ubuntu-latest" ]
          , steps =
              Checkout.plainDo
                [ [ let action = imports.gh-actions-dhall

                    in  action.mkStep
                          action.Common::{=}
                          action.Inputs::{ dhallVersion = "1.37.1" }
                  ]
                ]
          }
        }
    }
