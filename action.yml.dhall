let ActionSpec = ./ActionSpec.dhall

in    { name = "Dhall Actions"
      , description = "A couple of actions for checking dhall files"
      , runs =
          -- FIXME
          None <>
      , inputs = ./inputs/package.dhall
      }
    : ActionSpec
