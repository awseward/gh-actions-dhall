let imports = ../imports.dhall

let check-shell = imports.gh-actions-shell

let check-dhall = imports.gh-actions-dhall

let checkedOut = imports.checkedOut

in  { name = "CI"
    , on = [ "push" ]
    , jobs = toMap
        { check-shell =
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
