let Input = ./Input.dhall

in  { name : Text
    , description : Text
    , runs : Optional { `using` : Text, image : Text, args : List Text }
    , inputs : List { mapKey : Text, mapValue : Input }
    }
