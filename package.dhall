let mkPackage =
      https://raw.githubusercontent.com/awseward/dhall-misc/add-mkPackage/GHA/mkPackage.dhall

let Inputs = ./inputs.dhall

let id =
    -- Would like a better file name/location maybe
      ./actionId as Text

let version =
    -- Would like a better file name/location maybe
      ./actionVersion as Text

in  mkPackage Inputs.Type Inputs.{ toJSON } id version ⫽ { Inputs }
