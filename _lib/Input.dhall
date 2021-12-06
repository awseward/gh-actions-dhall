let JSON = ./JSON.dhall

in  { default : JSON.Type
    , deprecationMessage : Optional Text
    , description : Text
    , required : Bool
    }
