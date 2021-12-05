let InputSpec =
      { required : Bool, default : Optional Text, description : Optional Text }

in  { name : Text
    , description : Text
    , runs :
        -- FIXME
        Optional <>
    , inputs : List { mapKey : Text, mapValue : InputSpec }
    }
