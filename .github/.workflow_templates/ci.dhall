let imports = ../imports.dhall

let GHA = imports.GHA

let On = GHA.On

let action_templates = imports.action_templates

let Checkout = action_templates.actions/Checkout

in  GHA.Workflow::{
    , name = "CI"
    , on = On.names [ "push" ]
    , jobs = toMap
        { check-Dockerfile = GHA.Job::{
          , runs-on = [ "ubuntu-latest" ]
          , steps =
              Checkout.plainDo
                [ [ let action = action_templates.brpaz/Hadolint

                    in  action.mkStep action.Common::{=} action.Inputs::{=}
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
