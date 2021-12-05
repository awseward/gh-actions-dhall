let JSON = ./JSON.dhall

in  { default : Optional JSON.Type
    , deprecationMessage : Optional Text
    , description : Text
    , required : Bool
    }
