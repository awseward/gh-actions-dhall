let JSON =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/JSON/package.dhall

let InputSpec =
      { required : Bool
      , default : Optional JSON.Type
      , description : Optional Text
      }

in  { name : Text
    , description : Text
    , runs : Optional { `using` : Text, image : Text, args : List Text }
    , inputs : List { mapKey : Text, mapValue : InputSpec }
    }
